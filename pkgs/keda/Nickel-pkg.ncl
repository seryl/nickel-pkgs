# Amalgam Package Manifest
# Generated: 2025-09-01T19:42:30.403749+00:00
# Generator: amalgam v0.6.0
# Source: https://github.com/kedacore/keda/tree/v2.17.2/config/crd/bases
# Git ref: v2.17.2
{
  # Package identity
  name = "keda",
  version = "2.17.2",
  
  # Package information
  description = "KEDA autoscaling CRD type definitions",
  authors = ["amalgam"],
  keywords = ["autoscaling", "keda", "events", "kubernetes", "scaling"],
  license = "Apache-2.0",
  
  # Dependencies
  dependencies = {
    k8s_io = 'Index { package = "github:seryl/nickel-pkgs/pkgs/k8s-io", version = "1.33.4" }
  },
  
  # Nickel version requirement
  minimal_nickel_version = "1.9.0",
} | std.package.Manifest
