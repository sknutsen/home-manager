{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    _1password-gui
    thunderbird
  ];

  programs = {
    librewolf = {
      enable = true;
    };
  };
}
