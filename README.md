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

Packages can be imported directly from GitHub using Nickel's import system:

```nickel
# Import entire package modules
let k8s = import "github:seryl/nickel-pkgs/pkgs/k8s_io/mod.ncl" in
let crossplane = import "github:seryl/nickel-pkgs/pkgs/crossplane/mod.ncl" in

# Or import specific versions directly
let k8s_v1 = import "github:seryl/nickel-pkgs/pkgs/k8s_io/v1/mod.ncl" in

# Use type-safe configurations with full validation
let deployment = k8s_v1.Deployment & {
  apiVersion = "apps/v1",
  kind = "Deployment",
  metadata = k8s_v1.ObjectMeta & {
    name = "my-app",
    namespace = "default",
    labels = {
      app = "my-app",
      environment = "production"
    }
  },
  spec = k8s_v1.DeploymentSpec & {
    replicas = 3,
    selector = {
      matchLabels = {
        app = "my-app"
      }
    },
    template = k8s_v1.PodTemplateSpec & {
      metadata = k8s_v1.ObjectMeta & {
        labels = {
          app = "my-app"
        }
      },
      spec = k8s_v1.PodSpec & {
        containers = [{
          name = "app",
          image = "nginx:latest",
          ports = [{
            containerPort = 80
          }]
        }]
      }
    }
  }
} in

deployment
```

### Working with Cross-Package Dependencies

Packages automatically handle cross-package imports. For example, CrossPlane types reference Kubernetes ObjectMeta:

```nickel
# CrossPlane Composition using Kubernetes types
let crossplane = import "github:seryl/nickel-pkgs/pkgs/crossplane/apiextensions.crossplane.io/v1/mod.ncl" in

let composition = crossplane.Composition & {
  apiVersion = "apiextensions.crossplane.io/v1",
  kind = "Composition",
  metadata = {  # This automatically uses k8s_io ObjectMeta
    name = "my-composition",
    labels = {
      provider = "aws",
      complexity = "simple"
    }
  },
  spec = crossplane.CompositionSpec & {
    compositeTypeRef = {
      apiVersion = "example.io/v1",
      kind = "XDatabase"
    },
    # Additional spec fields...
  }
} in

composition
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

Each generated package follows a consistent structure:

### Package Organization
- **mod.ncl** - Main module file that exports all API versions
- **Version directories** (v1, v1beta1, v1alpha1, etc.) - API version-specific types
- **Individual type files** - One .ncl file per type with contracts and documentation
- **Automatic imports** - Cross-package dependencies resolved via relative paths

### Example Package Structure
```
pkgs/k8s_io/
├── mod.ncl                 # Main module exporting all versions
├── Nickel-pkg.ncl          # Package metadata
├── v1/
│   ├── mod.ncl            # v1 API module
│   ├── deployment.ncl     # Individual type definitions
│   ├── pod.ncl
│   └── ...
└── v1beta1/
    ├── mod.ncl
    └── ...
```

### Generated Type Example
```nickel
# deployment.ncl - Generated with full type safety and documentation
let deploymentstatus = import "./deploymentstatus.ncl" in
let objectmeta = import "./objectmeta.ncl" in
let deploymentspec = import "./deploymentspec.ncl" in

{
  # Deployment enables declarative updates for Pods and ReplicaSets
  Deployment = {
    apiVersion | optional | String | doc "API version",
    kind | optional | String | doc "Resource kind",
    metadata | optional | objectmeta.ObjectMeta | doc "Standard object metadata",
    spec | optional | deploymentspec.DeploymentSpec | doc "Deployment specification",
    status | optional | deploymentstatus.DeploymentStatus | doc "Current status",
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
This repository uses [Amalgam](https://github.com/seryl/amalgam) (currently v0.6.1) which provides:
- Universal schema parsing (Kubernetes CRDs, OpenAPI specs, Go types)
- Automatic cross-package import resolution with dependency tracking
- Idempotent package generation - same input always produces same output
- Type registry for managing complex type hierarchies
- Support for all Kubernetes API conventions and CRD formats

### Package Dependencies
All packages depend on the Kubernetes core types (k8s_io) for common types like ObjectMeta. The dependency graph is automatically managed by Amalgam during generation.

### Using This Repository as a Flake Module
Other Nix projects can import this repository to access both the packages and tooling:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nickel-pkgs.url = "github:seryl/nickel-pkgs";
  };

  outputs = { self, nixpkgs, nickel-pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      buildInputs = [
        # Get Nickel with package support
        nickel-pkgs.packages.${system}.nickel-with-packages
        # Get Amalgam for generating new types
        nickel-pkgs.packages.${system}.amalgam-bin
      ];
    };
  };
}
```

### CI/CD Pipeline
The repository includes a comprehensive CI pipeline that:
1. Generates all packages from `.amalgam-manifest.toml`
2. Validates all generated Nickel files with type checking
3. Ensures cross-package imports resolve correctly
4. Runs on every push via GitHub Actions

## 📜 License

This repository and its generated packages are available under the Apache License 2.0.

## 🙏 Acknowledgments

- Generated using [Amalgam](https://github.com/seryl/amalgam)
- For use with [Nickel](https://nickel-lang.org) configuration language
- Built with [Nix flakes](https://nixos.wiki/wiki/Flakes) for reproducible environments
