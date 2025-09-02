{
  description = "nickel-pkgs: Nickel Package Repository for Amalgam-Generated Types";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Amalgam for generating packages
    amalgam = {
      url = "github:seryl/amalgam/v0.6.4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Attic for binary caching
    attic = {
      url = "github:zhaofengli/attic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # You can add other flake-parts modules here
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = { config, self', inputs', pkgs, system, lib, ... }: let
        # Override pkgs to allow unfree packages
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        
        # Import all packages from the nix directory
        packages = import ./nix/packages.nix {
          inherit self' lib pkgs inputs';
        };

        inherit (packages)
          nickel-with-packages
          amalgam-bin
          attic-client
          ci-runner;

      in {
        # Packages exposed by this flake
        packages = packages;

        # Apps for direct execution
        apps = {
          default = {
            type = "app";
            program = "${ci-runner}/bin/ci-runner";
          };

          # Direct amalgam access
          amalgam = {
            type = "app";
            program = "${packages.amalgam-bin}/bin/amalgam";
          };
        };

        # Development shell
        devShells.default = pkgs.mkShell {
          buildInputs = with packages; [
            # Core tools
            nickel-with-packages
            amalgam-bin
            attic-client
            ci-runner

            # Development tools
            pkgs.claude-code

            # Utilities
            pkgs.jq
            pkgs.git
          ];

          shellHook = ''
            echo "📦 Nickel Package Repository"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
            echo "Development Commands:"
            echo "  amalgam                  - Generate Nickel types from CRDs/schemas"
            echo "  ci-runner generate       - Generate packages from manifest"
            echo "  ci-runner validate       - Validate all packages"
            echo "  ci-runner ci             - Run full pipeline"
            echo "  ci-runner help           - Show all CI commands"
            echo ""
            echo "Cache Setup (optional):"
            echo "  export ATTIC_SERVER=https://your-cache.com"
            echo "  export ATTIC_CACHE=nickel-pkgs"
            echo "  ci-runner cache-setup"
            echo ""

            # Check if packages exist
            if ls -d pkgs/*/ 2>/dev/null | grep -q .; then
              echo "Available Packages:"
              for dir in pkgs/*/; do
                if [ -f "$dir/mod.ncl" ]; then
                  basename "$dir"
                fi
              done | sed 's/^/  - /'
              echo ""
            fi
          '';

          # Default Attic configuration (can be overridden)
          ATTIC_SERVER = "";
          ATTIC_CACHE = "";
          ENABLE_ATTIC = "false";
        };

        # CI/CD checks that can be run with `nix flake check`
        checks = {
          # Validate existing packages
          validate = pkgs.runCommand "validate" {
            buildInputs = [ nickel-with-packages pkgs.findutils ];
          } ''
            mkdir -p $out
            cd $out

            # Copy repo content
            cp -r ${./.}/* . 2>/dev/null || true

            # Track if any validation fails
            failed=0

            # Find and validate .ncl files
            find . -name "*.ncl" -type f | while read -r file; do
              echo "Checking $file..."
              if ! ${nickel-with-packages}/bin/nickel typecheck "$file" 2>/dev/null; then
                echo "ERROR: Failed to validate $file"
                failed=1
              fi
            done

            if [ $failed -eq 1 ]; then
              echo "Validation failed!"
              exit 1
            fi

            echo "All packages validated successfully"
            touch $out/success
          '';
        };
      };
      
      # Export flake module for other flakes to import
      flake.flakeModules.default = import ./nix/nickel-packages.nix;
    };
}
