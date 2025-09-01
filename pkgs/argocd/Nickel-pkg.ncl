# Amalgam Package Manifest
# Generated: 2025-09-01T19:42:26.894937+00:00
# Generator: amalgam v0.6.0
# Source: https://github.com/argoproj/argo-cd/tree/v3.1.1/manifests/crds
# Git ref: v3.1.1
{
  # Package identity
  name = "argocd",
  version = "3.1.1",
  
  # Package information
  description = "ArgoCD CRD type definitions for GitOps",
  authors = ["amalgam"],
  keywords = ["gitops", "continuous-delivery", "kubernetes", "argo", "deployment"],
  license = "Apache-2.0",
  
  # Dependencies
  dependencies = {
    k8s_io = 'Index { package = "github:seryl/nickel-pkgs/pkgs/k8s-io", version = "1.33.4" }
  },
  
  # Nickel version requirement
  minimal_nickel_version = "1.9.0",
} | std.package.Manifest
