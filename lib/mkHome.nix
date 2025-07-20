{
  nixpkgs,
  overlays,
  inputs,
}: name: {
  system,
  user,
  darwin ? false,
  wsl ? false,
}: let
  isDarwin = darwin;
  isWSL = wsl;
  isLinux = !isDarwin && !isWSL;

  userHMConfig = ../users/${user};
  home-manager =
    if isDarwin
    then inputs.home-manager.darwinModules
    else inputs.home-manager.lib.homeManagerConfiguration;

  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
    };
    overlays = overlays;
  };
in
  home-manager rec {
    inherit pkgs;

    extraSpecialArgs = {
      inherit pkgs;
      inherit inputs;
      inherit isDarwin isLinux isWSL;
    };

    modules = [
      inputs.nvf.homeManagerModules.default
      inputs.zen-browser.homeModules.twilight

      userHMConfig

      ../comms
      ../dev
      ../desktop
      ../ghostty
      ../media
      ../nvim
      ../zen-browser
    ];
  }
