{
  description = "A highly structured configuration database.";

  nixConfig.extra-experimental-features = "nix-command flakes";
  nixConfig.extra-substituters = "https://nrdxp.cachix.org https://nix-community.cachix.org";
  nixConfig.extra-trusted-public-keys = "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";

  inputs =
    {
      # Track channels with commits tested and built by hydra
      nixos.url = "github:nixos/nixpkgs/nixos-22.05";
      latest.url = "github:nixos/nixpkgs/nixos-unstable";
      mach-nix.url = "github:DavHau/mach-nix";
      mach-nix.inputs.nixpkgs.follows = "nixos";

      digga.url = "github:divnix/digga";
      digga.inputs.latest.follows = "latest";
      digga.inputs.nixpkgs.follows = "nixos";
      digga.inputs.nixpkgs-unstable.follows = "latest";
      digga.inputs.nixlib.follows = "nixos";
      digga.inputs.home-manager.follows = "home";
      digga.inputs.deploy.follows = "deploy";

      home.url = "github:nix-community/home-manager/release-22.05";
      home.inputs.nixpkgs.follows = "nixos";

      deploy.url = "github:serokell/deploy-rs";
      deploy.inputs.nixpkgs.follows = "nixos";

      agenix.url = "github:ryantm/agenix";
      agenix.inputs.nixpkgs.follows = "nixos";

      nvfetcher.url = "github:berberman/nvfetcher";
      nvfetcher.inputs.nixpkgs.follows = "nixos";

      nixos-hardware.url = "github:nixos/nixos-hardware";
      nixos-generators.url = "github:nix-community/nixos-generators";

      nix2vim = {
        url = "github:gytis-ivaskevicius/nix2vim";
        inputs.nixpkgs.follows = "nixos";
      };


      # TODO: remove this when finished
      imagine-nvim = {
        url = "path:/home/sarios/Projects/imagine.nvim";
        flake = false;
      };
    };

  outputs =
    { self
    , digga
    , nixos
    , home
    , nixos-hardware
    , nur
    , agenix
    , nvfetcher
    , deploy
    , nix2vim
    , nixpkgs
    , ...
    } @ inputs:
    digga.lib.mkFlake
      {
        inherit self inputs;

        # TODO: change to false!
        channelsConfig = { allowUnfree = nixos.lib.mkForce true; };

        channels = {
          nixos = {
            imports = [ (digga.lib.importOverlays ./overlays) ];
            overlays = [ nix2vim.overlay ];
          };
          latest = { };
        };

        lib = import ./lib { lib = digga.lib // nixos.lib; };

        sharedOverlays = [
          (final: prev: {
            __dontExport = true;
            lib = prev.lib.extend (lfinal: lprev: {
              our = self.lib;
            });
          })

          nur.overlay
          agenix.overlay
          nvfetcher.overlay

          (final: prev: {
            __dontExport = true;
            vimPlugins = prev.vimPlugins // {
              # TODO: remove this!
              imagine-nvim = prev.vimUtils.buildVimPlugin {
                name = "imagine-nvim";
                src = inputs.imagine-nvim;
              };
            };
          })


          (import ./pkgs)
        ];

        nixos = {
          hostDefaults = {
            system = "x86_64-linux";
            channelName = "nixos";
            imports = [ (digga.lib.importExportableModules ./modules) ];
            modules = [
              { lib.our = self.lib; }
              digga.nixosModules.nixConfig
              home.nixosModules.home-manager
              agenix.nixosModules.age
            ];
          };

          imports = [ (digga.lib.importHosts ./hosts) ];
          hosts = {
            /* set host-specific properties here */
            NixOS = { };
          };
          importables = rec {
            profiles = digga.lib.rakeLeaves ./profiles // {
              users = digga.lib.rakeLeaves ./users;
            };
            suites = with profiles; rec {
              base = [ core.nixos users.nixos users.root ];
            };
          };
        };

        home = {
          imports = [ (digga.lib.importExportableModules ./users/modules) ];
          modules = [ ];
          importables = rec {
            profiles = digga.lib.rakeLeaves ./users/profiles;
            suites = with profiles; rec {
              base = [ direnv git ];
            };
          };
          users = {
            nixos = { suites, ... }: { imports = suites.base; };
          }; # digga.lib.importers.rakeLeaves ./users/hm;
        };

        devshell = ./shell;

        # TODO: similar to the above note: does it make sense to make all of
        # these users available on all systems?
        homeConfigurations = digga.lib.mergeAny
          (digga.lib.mkHomeConfigurations self.nixosConfigurations)
        ;

        deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };

      }
  ;
}
