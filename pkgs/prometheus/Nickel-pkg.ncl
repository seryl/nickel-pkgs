# Amalgam Package Manifest
# Generated: 2025-09-01T19:42:31.642643+00:00
# Generator: amalgam v0.6.0
# Source: https://github.com/prometheus-operator/prometheus-operator/tree/v0.85.0/example/prometheus-operator-crd
# Git ref: v0.85.0
{
  # Package identity
  name = "prometheus-operator",
  version = "0.85.0",
  
  # Package information
  description = "Prometheus Operator CRD type definitions",
  authors = ["amalgam"],
  keywords = ["prometheus", "monitoring", "observability", "kubernetes", "metrics"],
  license = "Apache-2.0",
  
  # Dependencies
  dependencies = {
    k8s_io = 'Index { package = "github:seryl/nickel-pkgs/pkgs/k8s-io", version = "1.33.4" }
  },
  
  # Nickel version requirement
  minimal_nickel_version = "1.9.0",
} | std.package.Manifest
