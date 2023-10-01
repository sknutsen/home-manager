{ pkgs, ... }:

let
  editor = pkgs.writeShellScriptBin "editor" ''
    neovim $0
  '';
in
{
  home.packages = [ editor ];
  programs.neovim = {
    enable = true;
    viAlias = true;
    defaultEditor = true;
  };
}
