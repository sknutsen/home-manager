{
  description = "Home Manager configuration of zdk";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    mkHome = import ./lib/mkHome.nix {
      inherit inputs;
    };
    # system = "x86_64-linux";
    # pkgs = import nixpkgs {
    #   inherit system;
    # };
  in {
    homeConfigurations = {
      "zdk@pingu" = mkHome "pingu" {
        system = "x86_64-linux";
        user = "zdk";
      };
      # "zdk@pingu" = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      #
      #   extraSpecialArgs = {
      #     inherit inputs;
      #   };
      #
      #   # Specify your home configuration modules here, for example,
      #   # the path to your home.nix.
      #   modules = [
      #     inputs.nvf.homeManagerModules.default
      #     inputs.zen-browser.homeModules.twilight
      #
      #     ./comms
      #     ./dev
      #     ./desktop
      #     ./ghostty
      #     ./media
      #     ./nvim
      #     ./zen-browser
      #
      #     ./users/zdk
      #   ];
      #
      #   # Optionally use extraSpecialArgs
      #   # to pass through arguments to home.nix
      # };

      "zdk@remorse" = mkHome "remorse" {
        system = "aarch64-darwin";
        user = "zdk";
        isDarwin = true;
      };
    };
  };
}
