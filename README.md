# nickel-pkgs

**Nickel Package Repository for [Amalgam](https://github.com/seryl/amalgam)-Generated Types**

This repository contains type-safe [Nickel](https://nickel-lang.org) configuration packages automatically generated using Amalgam from various schema sources including Kubernetes CRDs, OpenAPI specifications, and other type definitions. It serves as a centralized registry of strongly-typed Nickel definitions for infrastructure as code.

## 📦 Available Packages

This repository provides pre-generated, versioned type definitions from major Kubernetes ecosystem projects. All packages are defined in `.amalgam-manifest.toml` and generated from specific version tags to ensure reproducibility.

Current packages include:
- **Kubernetes Core Types** - Complete k8s.io API definitions
- **GitOps Tools** - ArgoCD, FluxCD (Kustomize & Source controllers)
- **Infrastructure** - CrossPlane, cert-manager
- **Scaling & Serverless** - KEDA, Knative
- **Observability** - Prometheus Operator
- **CI/CD** - Tekton Pipelines

See `.amalgam-manifest.toml` for the complete list with specific versions.

## 🚀 Quick Start

### Using Packages in Your Nickel Projects

```nickel
# Import Kubernetes types
let k8s = import "github:seryl/nickel-pkgs/pkgs/k8s_io/mod.ncl" in

# Import CrossPlane types  
let crossplane = import "github:seryl/nickel-pkgs/pkgs/crossplane/mod.ncl" in

# Use type-safe configurations
let deployment = k8s.apps.v1.Deployment & {
  metadata.name = "my-app",
  spec = {
    replicas = 3,
    # Full type checking and auto-completion
  }
}
```

## 📂 Repository Structure

```
nickel-pkgs/
├── .amalgam-manifest.toml     # Package generation manifest
├── flake.nix                 # Nix flake with dev environment
├── nix/                      # All Nix tooling
│   ├── ci-runner.nix        # CI orchestration
│   └── packages.nix         # Package definitions
└── pkgs/                     # Generated Nickel packages
    ├── k8s_io/              # Core Kubernetes types
    │   ├── mod.ncl          # Main module
    │   ├── v1/              # Core v1 API types
    │   └── v1beta1/         # Beta API types
    ├── crossplane/          # CrossPlane CRDs
    ├── argocd/              # ArgoCD CRDs
    └── ...                  # Other packages
```

## 🔧 Development Environment

This repository provides a complete development environment via Nix flakes:

```bash
# Enter development shell (or use direnv)
nix develop

# Then use built-in commands:
ci-runner ci          # Run full CI pipeline (generate + validate)
ci-runner generate    # Generate packages from manifest
ci-runner validate    # Validate all packages
amalgam --help       # Direct access to Amalgam

# Or use one-liners:
nix develop -c ci-runner ci
```

### Adding New Packages

To add a new package, edit `.amalgam-manifest.toml`:

```toml
[[packages]]
name = "my-operator"
type = "url"
url = "https://github.com/example/operator/tree/v1.0.0/crds"  # Use versioned URLs
git_ref = "v1.0.0"    # Specify the git reference
version = "1.0.0"      # Package version
output = "my-operator"
description = "My operator CRD type definitions"
keywords = ["operator", "kubernetes"]
dependencies = { k8s_io = "1.33.4" }
```

**Important**: Always use versioned URLs (tags/releases) rather than `main`/`master` branches to ensure reproducible package generation.

## 📝 Package Format

Each generated package follows this structure:
- **mod.ncl** - Main module file exporting all types
- **Version directories** - Organized by API version (v1, v1beta1, etc.)
- **Type files** - Individual .ncl files for each type definition
- **Smart imports** - Automatic cross-package import resolution

Example generated type:
```nickel
# composition.ncl
let k8s_io_v1 = import "../../k8s_io/v1/objectmeta.ncl" in

{
  Composition = {
    apiVersion | optional | String,
    kind | optional | String,
    metadata | optional | k8s_io_v1.ObjectMeta,
    spec | CompositionSpec,
  },
  
  CompositionSpec = {
    compositeTypeRef | { 
      apiVersion | String,
      kind | String,
    },
    # ... additional fields
  }
}
```

## 🤝 Contributing

To contribute new packages:
1. Edit `.amalgam-manifest.toml` to add your package definition
2. Run `nix develop -c ci-runner ci` to generate and validate
3. Ensure all packages use versioned URLs for reproducibility
4. Test that cross-package imports work correctly
5. Submit a pull request with your changes

The repository uses GitHub Actions for CI/CD, which automatically validates all packages on every push.

## 🛠️ Technical Details

### Amalgam Integration
This repository uses [Amalgam](https://github.com/seryl/amalgam) which provides:
- Universal schema parsing (CRDs, OpenAPI, Go types)
- Smart cross-package import resolution
- Idempotent package generation
- Type registry tracking

### Flake-Parts Composability
Other Nix flakes can import this repository as a module:
```nix
{
  inputs.nickel-pkgs.url = "github:seryl/nickel-pkgs";
  
  # Use the packages in your flake
  outputs = inputs: {
    # Access nickel-with-packages, amalgam, etc.
  };
}
```

## 📜 License

This repository and its generated packages are available under the Apache License 2.0.

## 🙏 Acknowledgments

- Generated using [Amalgam](https://github.com/seryl/amalgam)
- For use with [Nickel](https://nickel-lang.org) configuration language
- Built with [Nix flakes](https://nixos.wiki/wiki/Flakes) for reproducible environments
