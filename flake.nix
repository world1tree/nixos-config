{
  description = "Zaiheshi's Configuration for NixOS";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@github.com/world1tree/nix-secrets.git";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, agenix, home-manager, disko, secrets, ... } @inputs:
    let
      user = "zaiheshi";
      linuxSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs linuxSystems f;
      mkApp = scriptName: system: {
        type = "app";
        program = "${(nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
          #!/usr/bin/env bash
          PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
          echo "Running ${scriptName} for ${system}"
          exec ${self}/apps/${system}/${scriptName}
        '')}/bin/${scriptName}";
      };
      mkLinuxApps = system: {
        "apply" = mkApp "apply" system;
        "build-switch" = mkApp "build-switch" system;
        "copy-keys" = mkApp "copy-keys" system;
        "create-keys" = mkApp "create-keys" system;
        "check-keys" = mkApp "check-keys" system;
        "install-with-secrets" = mkApp "install-with-secrets" system;
      };
    in
    {
      templates = {
        starter = {
          path = ./templates/starter;
          description = "Starter configuration";
        };
      };
      apps = nixpkgs.lib.genAttrs linuxSystems mkLinuxApps;
    };
}
