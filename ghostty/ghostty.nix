{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      font-size = 14;
    };

    # themes = [];
  };
}
