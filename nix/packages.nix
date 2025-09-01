# Package definitions for flake-parts
{ self', lib, pkgs, inputs', ... }:

let
  # Use nickel-with-packages from amalgam (already has package support enabled)
  nickel-with-packages = inputs'.amalgam.packages.nickel-with-packages;

  # Amalgam binary from the flake
  amalgam-bin = inputs'.amalgam.packages.amalgam;

  # Attic client for cache management
  attic-client = inputs'.attic.packages.default;

  # CI runner script
  ci-runner = import ./ci-runner.nix {
    inherit pkgs amalgam-bin nickel-with-packages attic-client;
  };

  # Validation utilities
  validate-packages = pkgs.writeShellScriptBin "validate-packages" ''
    ${ci-runner}/bin/ci-runner validate
  '';

  test-imports = pkgs.writeShellScriptBin "test-imports" ''
    set -euo pipefail
    echo "Testing package imports..."
    
    for dir in pkgs/*/; do
      if [ -f "$dir/mod.ncl" ]; then
        echo "Testing import of $dir/mod.ncl..."
        echo "import \"$dir/mod.ncl\"" | ${nickel-with-packages}/bin/nickel repl 2>&1 | head -n 5
      fi
    done
    
    echo "✓ Import tests complete"
  '';

in {
  # Core tools
  inherit nickel-with-packages amalgam-bin attic-client ci-runner;
  
  # Utilities
  inherit validate-packages test-imports;
  
  # Default package
  default = ci-runner;
}