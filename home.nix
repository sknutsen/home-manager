{
  config,
  inputs,
  pkgs,
  ...
}: {
  home = {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    username = "zdk";
    homeDirectory = "/home/zdk";

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
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
    file = {
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

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/zdk/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
      EDITOR = "nvim";
    };

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.
  };

  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        package = pkgs.neovim-unwrapped;

        additionalRuntimePaths = [
          # ./nvim
          # (builtins.path {
          #   path = rootPath + /nvim;
          #   name = "nvim-runtime";
          # })
        ];

        spellcheck = {
          enable = true;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = true;
          otter-nvim.enable = false;
          nvim-docs-view.enable = false;
        };

        # This section does not include a comprehensive list of available language modules.
        # To list all available language module options, please visit the nvf manual.
        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          assembly.enable = false;
          astro.enable = false;
          bash.enable = true;
          clang.enable = true;
          csharp.enable = false;
          css.enable = true;
          dart.enable = false;
          elixir.enable = false;
          fsharp.enable = false;
          gleam.enable = false;
          go.enable = true;
          haskell.enable = false;
          html.enable = true;
          java.enable = false;
          julia.enable = false;
          kotlin.enable = false;
          lua.enable = true;
          markdown.enable = true;
          nix.enable = true;
          nu.enable = false;
          ocaml.enable = false;
          python.enable = true;
          r.enable = false;
          ruby.enable = false;
          rust = {
            enable = false;
            crates.enable = false;
          };
          scala.enable = false;
          sql.enable = true;
          svelte.enable = false;
          tailwind.enable = false;
          ts.enable = true;
          typst.enable = false;
          vala.enable = false;
          yaml.enable = true;
          zig.enable = true;

          # Nim LSP is broken on Darwin and therefore
          # should be disabled by default. Users may still enable
          # `vim.languages.vim` to enable it, this does not restrict
          # that.
          # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>
          nim.enable = false;
        };

        visuals = {
          nvim-scrollbar.enable = false;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;

          # Fun
          cellular-automaton.enable = false;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = false;
        };

        utility = {
          oil-nvim.enable = true;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;

        telescope = {
          enable = true;
        };
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
