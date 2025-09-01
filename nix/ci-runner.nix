# CI runner script for package generation and validation
{ pkgs, amalgam-bin, nickel-with-packages, attic-client }:

pkgs.writeShellApplication {
  name = "ci-runner";
  runtimeInputs = with pkgs; [
    amalgam-bin
    nickel-with-packages
    attic-client
    git
    jq
    yq
    coreutils
    findutils
  ];
  text = ''
    set -euo pipefail

    # Color output
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color

    # Parse command
    COMMAND="''${1:-help}"
    shift || true

    # Helper functions
    log_info() { echo -e "''${BLUE}[INFO]''${NC} $*"; }
    log_success() { echo -e "''${GREEN}[SUCCESS]''${NC} $*"; }
    log_warning() { echo -e "''${YELLOW}[WARNING]''${NC} $*"; }
    log_error() { echo -e "''${RED}[ERROR]''${NC} $*"; }

    # Setup Attic cache if configured
    setup_cache() {
      if [ -n "''${ATTIC_SERVER:-}" ] && [ -n "''${ATTIC_CACHE:-}" ]; then
        log_info "Configuring Attic cache: $ATTIC_SERVER/$ATTIC_CACHE"
        
        # Login if token provided
        if [ -n "''${ATTIC_TOKEN:-}" ]; then
          attic login "$ATTIC_SERVER" "$ATTIC_TOKEN"
        fi
        
        # Configure cache
        attic use "$ATTIC_CACHE"
        
        # Watch for new store paths to push
        if [ "''${ATTIC_WATCH:-false}" = "true" ]; then
          attic watch-store "$ATTIC_CACHE" &
          ATTIC_WATCH_PID=$!
          trap 'kill $ATTIC_WATCH_PID 2>/dev/null || true' EXIT
        fi
      else
        log_info "Attic cache not configured (set ATTIC_SERVER and ATTIC_CACHE)"
      fi
    }

    # Push results to cache
    push_to_cache() {
      local paths="$*"
      if [ -n "''${ATTIC_SERVER:-}" ] && [ -n "''${ATTIC_CACHE:-}" ]; then
        log_info "Pushing to Attic cache..."
        for path in $paths; do
          if [ -e "$path" ]; then
            attic push "$ATTIC_CACHE" "$path" || log_warning "Failed to push $path"
          fi
        done
      fi
    }

    # Generate packages function
    generate_packages() {
      log_info "Generating packages from manifest"
      
      # Check if manifest file exists
      if [ ! -f ".amalgam-manifest.toml" ]; then
        log_error "No .amalgam-manifest.toml found in current directory"
        return 1
      fi
      
      log_info "Using .amalgam-manifest.toml"
      amalgam generate-from-manifest --manifest .amalgam-manifest.toml
      
      log_success "Package generation complete"
    }

    # Validate packages function
    validate_packages() {
      log_info "Validating all Nickel packages..."
      
      local total=0
      local passed=0
      local failed=0
      
      while IFS= read -r -d "" file; do
        total=$((total + 1))
        
        # Skip test files
        if [[ "$file" == *"/test_"* ]] || [[ "$file" == *"/examples/"* ]]; then
          continue
        fi
        
        if nickel typecheck "$file" 2>/dev/null; then
          echo -e "  ''${GREEN}✓''${NC} $file"
          passed=$((passed + 1))
        else
          echo -e "  ''${RED}✗''${NC} $file"
          failed=$((failed + 1))
        fi
      done < <(find . -name "*.ncl" -type f -print0)
      
      log_info "Validation complete: $passed passed, $failed failed (total: $total)"
      
      if [ $failed -gt 0 ]; then
        log_error "Validation failed!"
        return 1
      fi
      
      log_success "All packages validated successfully!"
    }


    # Main command handler
    case "$COMMAND" in
      generate)
        setup_cache
        generate_packages
        push_to_cache ./pkgs
        ;;
      
      validate)
        validate_packages
        ;;
      
      all|ci)
        # Full CI pipeline
        setup_cache
        
        log_info "Running full CI pipeline..."
        
        # Generate packages
        generate_packages
        
        # Validate
        validate_packages
        
        # Push to cache
        push_to_cache ./pkgs
        
        log_success "CI pipeline complete!"
        ;;
      
      cache-setup)
        # Setup Attic cache
        setup_cache
        log_success "Cache configured"
        ;;
      
      cache-push)
        # Push specific paths to cache
        push_to_cache "$@"
        ;;
      
      help|*)
        cat << EOF
    Nickel Package CI Runner

    Usage: ci-runner <command> [options]

    Commands:
      generate                             Generate packages from manifest
      validate                             Validate all generated packages
      all|ci                               Run full CI pipeline
      cache-setup                          Configure Attic cache
      cache-push <paths...>                Push paths to cache
      help                                 Show this help

    Environment Variables:
      ATTIC_SERVER    Attic server URL (e.g., https://cache.example.com)
      ATTIC_CACHE     Attic cache name (e.g., nickel-pkgs)
      ATTIC_TOKEN     Attic auth token (optional)
      ATTIC_WATCH     Watch store for changes (true/false, default: false)

    Examples:
      # Run full CI pipeline
      ci-runner ci

      # Generate packages from manifest
      ci-runner generate

      # Setup cache and run CI
      export ATTIC_SERVER=https://cache.example.com
      export ATTIC_CACHE=nickel-pkgs
      ci-runner ci
    EOF
        
        if [ "$COMMAND" != "help" ]; then
          log_error "Unknown command: $COMMAND"
          exit 1
        fi
        ;;
    esac
  '';
}