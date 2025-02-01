{
  description = "Home Manager configuration of zdk";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      
      user = {
        name = "zdk";
        home = "/home/zdk";
        gitname = "sknutsen";
        email = "sondreknutsen1@gmail.com";
      };

      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."zdk" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = { inherit inputs user pkgs; };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
          inputs.nix-colors.homeManagerModules.default
          ./home.nix 
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
