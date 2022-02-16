{ config, pkgs, ... }: {

  # https://nix-community.github.io/home-manager/options.html
  home = {
    packages = with pkgs; [
      gh
      nixfmt
      nix-prefetch-scripts
      niv
      delta # https://dandavison.github.io/delta/
      tokei # https://github.com/XAMPPRocky/tokei
      (nerdfonts.override { fonts = [ "FiraCode" ]; }) # wsl上では意味ない
    ];

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "miyamo";
    homeDirectory =
      if pkgs.stdenv.isDarwin then "/Users/miyamo" else "/home/miyamo";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.05";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "miyamoen";
      userEmail = "akihito.biblioteca@gmail.com";
      aliases = {
        fap = "fetch --all --prune";
        sdom = "switch --detach origin/master";
      };
      delta = {
        enable = true;
        options = { };
      };
    };

    # https://github.com/cli/cli/issues/4955
    # モジュールで入れるとlogin時に設定ファイルに書き込もうとしてこけるので直るまでhome.packagesで入れる
    # gh.enable = true;

    lazygit = {
      enable = true;
      # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
      settings = {
        git.paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
        os = {
          editCommand = "code";
          editCommandTemplate = "{{editor}} --goto {{filename}}:{{line}}";
        };
      };
    };

    fish.enable = true;
    fish.plugins = [
      # nix用のpathとか設定してくれる
      {
        name = "nix-env.fish";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
          sha256 = "069ybzdj29s320wzdyxqjhmpm9ir5815yx6n522adav0z2nz8vs4";
        };
      }
    ];

    lsd.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [ "--cmd d" ]; # d, diにalias
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = { global.strict_env = true; };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = true;
        directory = {
          truncate_to_repo = false;
          home_symbol = "🏡";
        };
        battery.display.threshold = 50;
        character = {
          success_symbol = "[➜](bold green) ";
          error_symbol = "[✗](bold red) ";
        };
        cmd_duration.show_notifications = true;
        git_branch.symbol = "";
        nix_shell.symbol = "❄️";
      };
    };
  };

  fonts.fontconfig.enable = true;
}
