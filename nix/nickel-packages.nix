# Flake module for nickel-pkgs packages
# This can be imported by other flakes to access the Nickel packages
{ self, ... }:

{
  perSystem = { config, self', inputs', pkgs, system, lib, ... }: {
    # Export packages that other flakes can use
    packages = {
      # Nickel with package support enabled
      nickel-with-packages = pkgs.nickel.overrideAttrs (oldAttrs: {
        buildFeatures = (oldAttrs.buildFeatures or [ "default" ]) ++ [ "package-experimental" ];
        pname = "nickel-with-packages";
      });

      # Function to load all packages from this repository
      nickel-packages = pkgs.runCommand "nickel-packages" {} ''
        mkdir -p $out
        if [ -d "${self}/pkgs" ]; then
          cp -r ${self}/pkgs/* $out/ 2>/dev/null || true
        fi
      '';
    };

    # Export library functions for working with Nickel packages
    lib.nickel = {
      # Path to packages
      packagesPath = "${self}/pkgs";

      # Load a specific package
      loadPackage = name: version: 
        "${self}/pkgs/${name}/${version}/mod.ncl";

      # Create a Nickel configuration that imports packages
      mkNickelConfig = { imports ? [], ... }@attrs: 
        pkgs.writeText "config.ncl" ''
          ${lib.concatMapStrings (i: "let ${i.name} = import \"${i.path}\" in\n") imports}
          ${builtins.toJSON (builtins.removeAttrs attrs ["imports"])}
        '';
    };
  };
}