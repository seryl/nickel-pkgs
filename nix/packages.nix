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

in {
  # Core tools
  inherit nickel-with-packages amalgam-bin attic-client ci-runner;
  
  # Default package
  default = ci-runner;
}