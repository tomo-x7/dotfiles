{ config, pkgs, ... }:

{
  home.username = "tomo";
  home.homeDirectory = "/home/tomo";
  home.stateVersion = "26.11";
  home.packages = with pkgs; [
    gimp
    wezterm
  ];
  programs.git = {
    enable = true;
    settings.user = {
      name = "tomo-x7";
      email = "158121497+tomo-x7@users.noreply.github.com";
    };
  };

  home.file = {
    ".config/sway/config".source = ./sway/config;
  };

  programs.home-manager.enable = true;
}
