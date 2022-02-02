{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "miyamo";
  home.homeDirectory = "/home/miyamo";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "miyamoen";
    userEmail = "akihito.biblioteca@gmail.com";
    aliases = { st = "status"; };
  };

  # https://github.com/cli/cli/issues/4955
  # モジュールで入れるとlogin時に設定ファイルに書き込もうとしてこけるので直るまでhome.packagesで入れる
  # programs.gh.enable = true;

  home.packages = [ pkgs.gh pkgs.nixfmt ];
}
