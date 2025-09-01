# Amalgam Package Manifest
# Generated: 2025-09-01T19:42:29.199694+00:00
# Generator: amalgam v0.6.0
# Source: https://github.com/fluxcd/kustomize-controller/tree/v1.6.1/config/crd/bases
# Git ref: v1.6.1
{
  # Package identity
  name = "fluxcd-kustomize",
  version = "1.6.1",
  
  # Package information
  description = "FluxCD Kustomize Controller CRD type definitions",
  authors = ["amalgam"],
  keywords = ["gitops", "fluxcd", "kustomize", "kubernetes", "configuration"],
  license = "Apache-2.0",
  
  # Dependencies
  dependencies = {
    k8s_io = 'Index { package = "github:seryl/nickel-pkgs/pkgs/k8s-io", version = "1.33.4" }
  },
  
  # Nickel version requirement
  minimal_nickel_version = "1.9.0",
} | std.package.Manifest
