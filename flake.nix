{
  description = "Home Manager configuration of zdk";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixgl.url = "github:nix-community/nixGL";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixgl, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = system;
        overlays = [
          (self: super: {
            vulkan-validation-layers =
              super.vulkan-validation-layers.overrideAttrs (oldAttrs: {
                buildInputs = oldAttrs.buildInputs ++ [ super.spirv-tools ];
              });
          })
          nixgl.overlay 
        ];
      };
    in {
      homeConfigurations.zdk = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # extraSpecialArgs = { inherit inputs pkgs; };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
