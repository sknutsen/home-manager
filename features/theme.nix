{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3-dark";
    iconTheme.package = pkgs.whitesur-icon-theme;
    iconTheme.name = "WhiteSur-dark";
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
  };
}