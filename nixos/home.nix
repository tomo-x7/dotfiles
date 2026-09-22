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
h
  xdg.configFile = {
    "sway/config".source = ../sway/config;
    # "waybar/config.jsonc".source = ../waybar/config.jsonc;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.waybar = {
    enable = true;
    
  };

  programs.home-manager.enable = true;
}
