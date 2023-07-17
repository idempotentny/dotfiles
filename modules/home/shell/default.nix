{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    skim = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };
    exa.enable = true;
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    dircolors = {
      enable = true;
      enableFishIntegration = true;
    };
    # TODO: add bat config
    # TODO: add some fish extensions

    fish = {
      enable = true;
      shellAliases = with pkgs; {
        ".." = "z .. && exa --icons --colour always";
        "..." = "z ../../ && exa --icons --colour always";
        "...." = "z ../../../ && exa --icons --colour always";
        "vim" = "hx";
        "nb" = "newsboat";
        # FIXME
        "cat" = "bat --style=plain";
        "du" = "${du-dust}/bin/dust";
        # "ll" = "ls -l --time-style long-iso --icons";
        "tb" = "toggle-background";
        "dbt" = "bluetoothctl disconnect";
        "cleanup" = "doas nix-collect-garbage --delete-older-than 7d";
        "grep" = "rg -i";
        # "fzf" = "skim";
        "untar" = "tar -xvf";
        "untargz" = "tar -xzf";
        "m" = "mkdir -p";
        # "fcd" = "cd $(find -type d | fzf)";
        # "l" = "ls -lF --time-style=long-iso --icons";
        "sc" = "doas systemctl";
        "scu" = "systemctl --user ";
        "la" = "exa -lah --tree";
        "ls" = "exa -h --git --icons --color=auto --group-directories-first -s extension";
        "tree" = "exa --tree --icons --tree";
        # "diff" = "diff --color=auto";
      };
      shellInit = ''
        set -U fish_term24bit 1
        ulimit -n 16384
        ulimit -u 2048
      '';

      interactiveShellInit = ''
        set -g fish_greeting ""
        set -g fish_color_normal e0def4
        set -g fish_color_command c4a7e7
        set -g fish_color_keyword 9ccfd8
        set -g fish_color_quote f6c177
        set -g fish_color_redirection 3e8fb0
        set -g fish_color_end 908caa
        set -g fish_color_error eb6f92
        set -g fish_color_param ea9a97
        set -g fish_color_comment 908caa
        set -g fish_color_match --background=brblue
        set -g fish_color_selection --reverse
        set -g fish_color_history_current --bold
        set -g fish_color_operator e0def4
        set -g fish_color_escape 3e8fb0
        set -g fish_color_autosuggestion 908caa
        set -g fish_color_cwd ea9a97
        set -g fish_color_cwd_root red
        set -g fish_color_user f6c177
        set -g fish_color_host 9ccfd8
        set -g fish_color_host_remote c4a7e7
        set -g fish_color_cancel e0def4
        set -g fish_color_search_match --background=232136
        set -g fish_color_valid_path
      '';
    };
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        command_timeout = 1000;
        cmd_duration = {
          format = " [$duration]($style) ";
          style = "bold #EC7279";
          show_notifications = true;
        };
        directory = {truncate_to_repo = false;};
        nix_shell = {format = " [$symbol$state]($style) ";};
        battery = {
          full_symbol = "󰁹 ";
          charging_symbol = " ";
          discharging_symbol = " ";
        };
        git_branch = {
          format = "[$symbol$branch]($style) ";
          symbol = " ";
        };
        gcloud = {
          format = "[$symbol$active]($style) ";
          symbol = "  ";
        };
        aws = {symbol = "  ";};
        buf = {symbol = " ";};
        c = {symbol = " ";};
        conda = {symbol = " ";};
        dart = {symbol = " ";};
        directory = {read_only = " 󰌾";};
        docker_context = {symbol = " ";};
        elixir = {symbol = " ";};
        elm = {symbol = " ";};
        golang = {symbol = " ";};
        haskell = {symbol = " ";};
        hg_branch = {symbol = "  ";};
        java = {symbol = " ";};
        julia = {symbol = " ";};
        lua = {symbol = " ";};
        memory_usage = {symbol = " ";};
        nim = {symbol = " ";};
        nix_shell = {symbol = " ";};
        nodejs = {symbol = " ";};
        package = {symbol = " ";};
        python = {symbol = " ";};
        rust = {symbol = " ";};
      };
    };
  };
}
