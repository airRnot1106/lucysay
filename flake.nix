{
  inputs = {
    devenv.url = "github:cachix/devenv";
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.git-hooks.flakeModule
        inputs.devenv.flakeModule
        inputs.treefmt-nix.flakeModule
      ];
      systems = import inputs.systems;

      perSystem =
        {
          config,
          lib,
          pkgs,
          system,
          ...
        }:
        {
          devenv.shells.default = {
            packages = with pkgs; [
              beam28Packages.rebar3
              git
              nil
            ];
            containers = lib.mkForce { };
            languages = {
              erlang = {
                enable = true;
              };
              gleam = {
                enable = true;
              };
            };
            enterShell = ''
              ${config.pre-commit.installationScript}
            '';
          };

          pre-commit = import ./nix/pre-commit { inherit config; };
          treefmt = import ./nix/treefmt;
        };
    };
}
