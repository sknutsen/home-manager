{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.ghostty.settings.keybind = [
    # Key bindings. The format is `trigger=action`. Duplicate triggers will
    # overwrite previously set values. The list of actions is available in
    # the documentation or using the `ghostty +list-actions` command.
    #
    # Trigger: `+`-separated list of keys and modifiers. Example: `ctrl+a`,
    # `ctrl+shift+b`, `up`.
    #
    # Valid keys are currently only listed in the
    # [Ghostty source code](https://github.com/ghostty-org/ghostty/blob/d6e76858164d52cff460fedc61ddf2e560912d71/src/input/key.zig#L255).
    # This is a documentation limitation and we will improve this in the future.
    # A common gotcha is that numeric keys are written as words: e.g. `one`,
    # `two`, `three`, etc. and not `1`, `2`, `3`. This will also be improved in
    # the future.
    #
    # Valid modifiers are `shift`, `ctrl` (alias: `control`), `alt` (alias: `opt`,
    # `option`), and `super` (alias: `cmd`, `command`). You may use the modifier
    # or the alias. When debugging keybinds, the non-aliased modifier will always
    # be used in output.
    #
    # Note: The fn or "globe" key on keyboards are not supported as a
    # modifier. This is a limitation of the operating systems and GUI toolkits
    # that Ghostty uses.
    #
    # Some additional notes for triggers:
    #
    #   * modifiers cannot repeat, `ctrl+ctrl+a` is invalid.
    #
    #   * modifiers and keys can be in any order, `shift+a+ctrl` is *weird*,
    #     but valid.
    #
    #   * only a single key input is allowed, `ctrl+a+b` is invalid.
    #
    #   * the key input can be prefixed with `physical:` to specify a
    #     physical key mapping rather than a logical one. A physical key
    #     mapping responds to the hardware keycode and not the keycode
    #     translated by any system keyboard layouts. Example: "ctrl+physical:a"
    #
    # You may also specify multiple triggers separated by `>` to require a
    # sequence of triggers to activate the action. For example,
    # `ctrl+a>n=new_window` will only trigger the `new_window` action if the
    # user presses `ctrl+a` followed separately by `n`. In other software, this
    # is sometimes called a leader key, a key chord, a key table, etc. There
    # is no hardcoded limit on the number of parts in a sequence.
    #
    # Warning: If you define a sequence as a CLI argument to `ghostty`,
    # you probably have to quote the keybind since `>` is a special character
    # in most shells. Example: ghostty --keybind='ctrl+a>n=new_window'
    #
    # A trigger sequence has some special handling:
    #
    #   * Ghostty will wait an indefinite amount of time for the next key in
    #     the sequence. There is no way to specify a timeout. The only way to
    #     force the output of a prefix key is to assign another keybind to
    #     specifically output that key (e.g. `ctrl+a>ctrl+a=text:foo`) or
    #     press an unbound key which will send both keys to the program.
    #
    #   * If a prefix in a sequence is previously bound, the sequence will
    #     override the previous binding. For example, if `ctrl+a` is bound to
    #     `new_window` and `ctrl+a>n` is bound to `new_tab`, pressing `ctrl+a`
    #     will do nothing.
    #
    #   * Adding to the above, if a previously bound sequence prefix is
    #     used in a new, non-sequence binding, the entire previously bound
    #     sequence will be unbound. For example, if you bind `ctrl+a>n` and
    #     `ctrl+a>t`, and then bind `ctrl+a` directly, both `ctrl+a>n` and
    #     `ctrl+a>t` will become unbound.
    #
    #   * Trigger sequences are not allowed for `global:` or `all:`-prefixed
    #     triggers. This is a limitation we could remove in the future.
    #
    # Action is the action to take when the trigger is satisfied. It takes the
    # format `action` or `action:param`. The latter form is only valid if the
    # action requires a parameter.
    #
    #   * `ignore` - Do nothing, ignore the key input. This can be used to
    #     black hole certain inputs to have no effect.
    #
    #   * `unbind` - Remove the binding. This makes it so the previous action
    #     is removed, and the key will be sent through to the child command
    #     if it is printable. Unbind will remove any matching trigger,
    #     including `physical:`-prefixed triggers without specifying the
    #     prefix.
    #
    #   * `csi:text` - Send a CSI sequence. e.g. `csi:A` sends "cursor up".
    #
    #   * `esc:text` - Send an escape sequence. e.g. `esc:d` deletes to the
    #     end of the word to the right.
    #
    #   * `text:text` - Send a string. Uses Zig string literal syntax.
    #     e.g. `text:\x15` sends Ctrl-U.
    #
    #   * All other actions can be found in the documentation or by using the
    #     `ghostty +list-actions` command.
    #
    # Some notes for the action:
    #
    #   * The parameter is taken as-is after the `:`. Double quotes or
    #     other mechanisms are included and NOT parsed. If you want to
    #     send a string value that includes spaces, wrap the entire
    #     trigger/action in double quotes. Example: `--keybind="up=csi:A B"`
    #
    # There are some additional special values that can be specified for
    # keybind:
    #
    #   * `keybind=clear` will clear all set keybindings. Warning: this
    #     removes ALL keybindings up to this point, including the default
    #     keybindings.
    #
    # The keybind trigger can be prefixed with some special values to change
    # the behavior of the keybind. These are:
    #
    #   * `all:` - Make the keybind apply to all terminal surfaces. By default,
    #     keybinds only apply to the focused terminal surface. If this is true,
    #     then the keybind will be sent to all terminal surfaces. This only
    #     applies to actions that are surface-specific. For actions that
    #     are already global (e.g. `quit`), this prefix has no effect.
    #
    #   * `global:` - Make the keybind global. By default, keybinds only work
    #     within Ghostty and under the right conditions (application focused,
    #     sometimes terminal focused, etc.). If you want a keybind to work
    #     globally across your system (e.g. even when Ghostty is not focused),
    #     specify this prefix. This prefix implies `all:`. Note: this does not
    #     work in all environments; see the additional notes below for more
    #     information.
    #
    #   * `unconsumed:` - Do not consume the input. By default, a keybind
    #     will consume the input, meaning that the associated encoding (if
    #     any) will not be sent to the running program in the terminal. If
    #     you wish to send the encoded value to the program, specify the
    #     `unconsumed:` prefix before the entire keybind. For example:
    #     `unconsumed:ctrl+a=reload_config`. `global:` and `all:`-prefixed
    #     keybinds will always consume the input regardless of this setting.
    #     Since they are not associated with a specific terminal surface,
    #     they're never encoded.
    #
    #   * `performable:` - Only consume the input if the action is able to be
    #     performed. For example, the `copy_to_clipboard` action will only
    #     consume the input if there is a selection to copy. If there is no
    #     selection, Ghostty behaves as if the keybind was not set. This has
    #     no effect with `global:` or `all:`-prefixed keybinds. For key
    #     sequences, this will reset the sequence if the action is not
    #     performable (acting identically to not having a keybind set at
    #     all).
    #
    #     Performable keybinds will not appear as menu shortcuts in the
    #     application menu. This is because the menu shortcuts force the
    #     action to be performed regardless of the state of the terminal.
    #     Performable keybinds will still work, they just won't appear as
    #     a shortcut label in the menu.
    #
    # Keybind triggers are not unique per prefix combination. For example,
    # `ctrl+a` and `global:ctrl+a` are not two separate keybinds. The keybind
    # set later will overwrite the keybind set earlier. In this case, the
    # `global:` keybind will be used.
    #
    # Multiple prefixes can be specified. For example,
    # `global:unconsumed:ctrl+a=reload_config` will make the keybind global
    # and not consume the input to reload the config.
    #
    # Note: `global:` is only supported on macOS. On macOS,
    # this feature requires accessibility permissions to be granted to Ghostty.
    # When a `global:` keybind is specified and Ghostty is launched or reloaded,
    # Ghostty will attempt to request these permissions. If the permissions are
    # not granted, the keybind will not work. On macOS, you can find these
    # permissions in System Preferences -> Privacy & Security -> Accessibility.abort

    # Tabs
    "ctrl+shift+t=new_tab"
    "ctrl+shift+w=close_tab"
    "alt+one=goto_tab:1"
    "alt+two=goto_tab:2"
    "alt+three=goto_tab:3"
    "alt+four=goto_tab:4"
    "alt+five=goto_tab:5"
    "alt+six=goto_tab:6"
    "alt+seven=goto_tab:7"
    "alt+eight=goto_tab:8"
    "alt+nine=last_tab"
    "ctrl+page_down=next_tab"
    "ctrl+tab=next_tab"
    "ctrl+shift+right=next_tab"
    "ctrl+shift+left=previous_tab"
    "ctrl+page_up=previous_tab"
    "ctrl+shift+tab=previous_tab"

    # Config
    "ctrl+comma=open_config"
    "ctrl+shift+comma=reload_config"

    # Clipboard
    "ctrl+shift+c=copy_to_clipboard"
    "ctrl+insert=copy_to_clipboard"
    "shift+insert=paste_from_selection"
    "ctrl+shift+v=paste_from_clipboard"

    # Splits
    "ctrl+shift+o=new_split:right"
    "ctrl+shift+e=new_split:down"
    "super+ctrl+shift+plus=equalize_splits"
    "super+ctrl+right_bracket=goto_split:next"
    "super+ctrl+left_bracket=goto_split:previous"
    "ctrl+alt+left=goto_split:left"
    "ctrl+alt+right=goto_split:right"
    "ctrl+alt+up=goto_split:up"
    "ctrl+alt+down=goto_split:down"
    "super+ctrl+shift+up=resize_split:up,10"
    "super+ctrl+shift+down=resize_split:down,10"
    "super+ctrl+shift+left=resize_split:left,10"
    "super+ctrl+shift+right=resize_split:right,10"
    "ctrl+shift+enter=toggle_split_zoom"

    # Selection
    "ctrl+shift+a=select_all"
    "shift+up=adjust_selection:up"
    "shift+left=adjust_selection:left"
    "shift+right=adjust_selection:right"
    "shift+down=adjust_selection:down"

    # Font
    "ctrl+equal=increase_font_size:1"
    "ctrl+plus=increase_font_size:1"
    "ctrl+minus=decrease_font_size:1"
    "ctrl+zero=reset_font_size"

    # Control
    "ctrl+shift+q=quit"
    "ctrl+alt+shift+j=write_screen_file:open"
    "ctrl+shift+j=write_screen_file:paste"
    "ctrl+enter=toggle_fullscreen"
    "ctrl+shift+i=inspector:toggle"

    # Windows
    "ctrl+shift+n=new_window"
    "alt+f4=close_window"

    # Navigation
    "ctrl+shift+page_down=jump_to_prompt:1"
    "ctrl+shift+page_up=jump_to_prompt:-1"
    "shift+home=scroll_to_top"
    "shift+end=scroll_to_bottom"
    "shift+page_up=scroll_page_up"
    "shift+page_down=scroll_page_down"
  ];
}
