# Amalgam Package Manifest
# Generated: 2025-09-01T19:42:32.444514+00:00
# Generator: amalgam v0.6.0
# Source: https://github.com/tektoncd/pipeline/tree/v1.3.1/config/300-crds
# Git ref: v1.3.1
{
  # Package identity
  name = "tekton",
  version = "1.3.1",
  
  # Package information
  description = "Tekton CI/CD pipeline CRD type definitions",
  authors = ["amalgam"],
  keywords = ["ci-cd", "pipelines", "tekton", "kubernetes", "automation"],
  license = "Apache-2.0",
  
  # Dependencies
  dependencies = {
    k8s_io = 'Index { package = "github:seryl/nickel-pkgs/pkgs/k8s-io", version = "1.33.4" }
  },
  
  # Nickel version requirement
  minimal_nickel_version = "1.9.0",
} | std.package.Manifest
