{ config, pkgs, ... }:

{
  home.stateVersion = "26.11";
  home.packages = with pkgs; [
    
  ];
  programs.git = {
    enable = true;
    userName = "tomo-x7";
    userEmail = "158121497+tomo-x7@users.noreply.github.com";
  };

  programs.home-manager.enable = true;
}
