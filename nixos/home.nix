{ config, pkgs, ... }:

{
  home.stateVersion = "26.11";
  home.packages = with pkgs; [
    
  ];
  programs.git = {
    enable = true;
    userName = "tomo-x7";
  };

  programs.home-manager.enable = true;
}
