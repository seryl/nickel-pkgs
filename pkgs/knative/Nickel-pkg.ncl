# Amalgam Package Manifest
# Generated: 2025-09-01T22:55:02.420780+00:00
# Generator: amalgam v0.6.3
# Source: https://github.com/knative/operator/tree/knative-v1.17.8/config/crd/bases
# Git ref: knative-v1.17.8
{
  # Package identity
  name = "knative",
  version = "1.17.8",
  
  # Package information
  description = "Knative Operator CRD type definitions",
  authors = ["amalgam"],
  keywords = ["serverless", "knative", "functions", "kubernetes", "scale-to-zero"],
  license = "Apache-2.0",
  
  # Dependencies
  dependencies = {
    k8s_io = 'Index { package = "github:seryl/nickel-pkgs/pkgs/k8s-io", version = "1.33.4" }
  },
  
  # Nickel version requirement
  minimal_nickel_version = "1.9.0",
} | std.package.Manifest
