{ config, pkgs, ... }:

{
  home.username = "tomo";
  home.homeDirectory = "/home/tomo";
  home.stateVersion = "26.11";
  home.packages = with pkgs; [
    
  ];
  programs.git = {
    enable = true;
    settings.user = {
      name = "tomo-x7";
      email = "158121497+tomo-x7@users.noreply.github.com";
    };
  };

  programs.home-manager.enable = true;
}
