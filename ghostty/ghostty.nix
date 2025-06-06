{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {};

    themes = [];
  };
}
