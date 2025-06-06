{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.ghostty.settings.keybind = [
    "ctrl+shift+t=new_tab"
    "alt+one=goto_tab:1"
    "alt+two=goto_tab:2"
    "alt+three=goto_tab:3"
    "alt+four=goto_tab:4"
    "alt+five=goto_tab:5"
    "alt+six=goto_tab:6"
    "alt+seven=goto_tab:7"
    "alt+eight=goto_tab:8"
  ];
}
