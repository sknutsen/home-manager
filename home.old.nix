{ config, lib, nix-colors, pkgs, inputs, user, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./features/browser.nix
    ./features/editor.nix
    ./features/theme.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.nord;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = user.name;
  home.homeDirectory = user.home;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/zdk/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    plugins = with pkgs; [
      # {
      #   name = "agkozak-zsh-prompt";
      #   src = fetchFromGitHub {
      #     owner = "agkozak";
      #     repo = "agkozak-zsh-prompt";
      #     rev = "v3.7.0";
      #     sha256 = "1iz4l8777i52gfynzpf6yybrmics8g4i3f1xs3rqsr40bb89igrs";
      #   };
      #   file = "agkozak-zsh-prompt.plugin.zsh";
      # }
      # {
      #   name = "formarks";
      #   src = fetchFromGitHub {
      #     owner = "wfxr";
      #     repo = "formarks";
      #     rev = "8abce138218a8e6acd3c8ad2dd52550198625944";
      #     sha256 = "1wr4ypv2b6a2w9qsia29mb36xf98zjzhp3bq4ix6r3cmra3xij90";
      #   };
      #   file = "formarks.plugin.zsh";
      # }
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      # {
      #   name = "zsh-abbrev-alias";
      #   src = fetchFromGitHub {
      #     owner = "momo-lab";
      #     repo = "zsh-abbrev-alias";
      #     rev = "637f0b2dda6d392bf710190ee472a48a20766c07";
      #     sha256 = "16saanmwpp634yc8jfdxig0ivm1gvcgpif937gbdxf0csc6vh47k";
      #   };
      #   file = "abbrev-alias.plugin.zsh";
      # }
      # {
      #   name = "zsh-autopair";
      #   src = fetchFromGitHub {
      #     owner = "hlissner";
      #     repo = "zsh-autopair";
      #     rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
      #     sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
      #   };
      #   file = "autopair.zsh";
      # }
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
