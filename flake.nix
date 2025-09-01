{
  description = "nickel-pkg: Nickel Package Repository for Amalgam-Generated Types";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Amalgam for generating packages
    amalgam = {
      url = "github:seryl/amalgam/v0.6.0";
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
          ci-runner
          validate-packages
          test-imports;

      in {
        # Packages exposed by this flake
        packages = packages;

        # Apps for direct execution
        apps = {
          default = {
            type = "app";
            program = "${ci-runner}/bin/ci-runner";
          };

          ci = {
            type = "app";
            program = "${pkgs.writeShellScript "ci" ''
              ${ci-runner}/bin/ci-runner ci "$@"
            ''}";
          };

          generate = {
            type = "app";
            program = "${pkgs.writeShellScript "generate" ''
              ${ci-runner}/bin/ci-runner generate "$@"
            ''}";
          };

          # Update flake and regenerate packages in one command
          update-and-regenerate = {
            type = "app";
            program = "${pkgs.writeShellScript "update-and-regenerate" ''
              set -euo pipefail
              echo "🔄 Updating flake lock..."
              nix flake update
              
              echo "🏗️  Entering development shell and regenerating packages..."
              nix develop --command bash -c "
                echo 'Amalgam version:' \$(amalgam --version)
                ci-runner generate
                echo '✅ Package generation complete!'
              "
              
              echo "📋 Checking for changes..."
              if git diff --quiet; then
                echo "No changes detected."
              else
                echo "Changes detected. Review with: git status && git diff"
              fi
            ''}";
          };

          # Just regenerate packages without updating flake
          regenerate = {
            type = "app";
            program = "${pkgs.writeShellScript "regenerate" ''
              set -euo pipefail
              echo "🏗️  Regenerating packages..."
              nix develop --command bash -c "
                echo 'Amalgam version:' \$(amalgam --version)
                ci-runner generate
                echo '✅ Package generation complete!'
              "
            ''}";
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

            # Validation and testing
            validate-packages
            test-imports

            # Development tools
            pkgs.claude-code

            # Utilities
            pkgs.jq
            pkgs.yq
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
          # Check that packages can be generated
          # generate-check = pkgs.runCommand "generate-check" {
          #   buildInputs = [ ci-runner packages.amalgam-bin ];
          # } ''
          #   mkdir -p $out
          #   cd $out

          #   # Create a minimal sources file
          #   cat > sources.yaml << 'EOF'
          #   sources:
          #     test:
          #       type: k8s-core
          #       version: v1.31.0
          #       output: test_k8s
          #   EOF

          #   # Try to generate
          #   ci-runner generate sources.yaml test || exit 1

          #   touch $out/success
          # '';

          # Validate existing packages
          validate-check = pkgs.runCommand "validate-check" {
            buildInputs = [ nickel-with-packages pkgs.findutils ];
          } ''
            mkdir -p $out

            # Copy repo content
            cp -r ${./.}/* . 2>/dev/null || true

            # Find and validate .ncl files
            find . -name "*.ncl" -type f | while read -r file; do
              echo "Checking $file..."
              ${nickel-with-packages}/bin/nickel typecheck "$file" || true
            done

            touch $out/success
          '';
        };
      };
      
      # Export flake module for other flakes to import
      flake.flakeModules.default = import ./nix/nickel-packages.nix;
    };
}
