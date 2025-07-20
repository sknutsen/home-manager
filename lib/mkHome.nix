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

  userHMConfig = ../users/${user}/home.nix;
  home-manager =
    if isDarwin
    then inputs.home-manager.darwinModules
    else inputs.home-manager.lib.homeManagerConfiguration;

  pkgs = import nixpkgs {
    inherit system;
  };
in
  home-manager rec {
    inherit system pkgs;

    extraSpecialArgs = {
      inherit pkgs;
      inherit inputs;
      inherit isDarwin isLinux isWSL;
    };

    modules = [
      inputs.nvf.homeManagerModules.default
      inputs.zen-browser.homeModules.twilight

      ../comms
      ../dev
      ../desktop
      ../ghostty
      ../media
      ../nvim
      ../zen-browser

      userHMConfig
    ];
  }
