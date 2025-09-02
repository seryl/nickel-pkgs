# Amalgam Package Manifest
# Generated: 2025-09-01T22:55:01.214202+00:00
# Generator: amalgam v0.6.3
# Source: https://github.com/fluxcd/source-controller/tree/v1.6.2/config/crd/bases
# Git ref: v1.6.2
{
  # Package identity
  name = "fluxcd-source",
  version = "1.6.2",
  
  # Package information
  description = "FluxCD Source Controller CRD type definitions",
  authors = ["amalgam"],
  keywords = ["gitops", "fluxcd", "continuous-delivery", "kubernetes", "source"],
  license = "Apache-2.0",
  
  # Dependencies
  dependencies = {
    k8s_io = 'Index { package = "github:seryl/nickel-pkgs/pkgs/k8s-io", version = "1.33.4" }
  },
  
  # Nickel version requirement
  minimal_nickel_version = "1.9.0",
} | std.package.Manifest
