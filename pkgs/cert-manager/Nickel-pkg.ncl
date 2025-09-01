# Amalgam Package Manifest
# Generated: 2025-09-01T19:42:27.601977+00:00
# Generator: amalgam v0.6.0
# Source: https://github.com/cert-manager/cert-manager/tree/v1.18.2/deploy/crds
# Git ref: v1.18.2
{
  # Package identity
  name = "cert-manager",
  version = "1.18.2",
  
  # Package information
  description = "cert-manager CRD type definitions for Nickel",
  authors = ["amalgam"],
  keywords = ["certificates", "tls", "security", "kubernetes", "acme"],
  license = "Apache-2.0",
  
  # Dependencies
  dependencies = {
    k8s_io = 'Index { package = "github:seryl/nickel-pkgs/pkgs/k8s-io", version = "1.33.4" }
  },
  
  # Nickel version requirement
  minimal_nickel_version = "1.9.0",
} | std.package.Manifest
