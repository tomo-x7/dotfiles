{ config, pkgs, ... }:

{
  home.username = "tomo";
  home.homeDirectory = "/home/tomo";
  home.stateVersion = "26.11";
  home.packages = with pkgs; [
    gimp
    wezterm
    vscode
    pnpm_11
    nodejs_26
    
  ];
  programs.git = {
    enable = true;
    settings.user = {
      name = "tomo-x7";
      email = "158121497+tomo-x7@users.noreply.github.com";
    };
  };
  
  xdg.configFile = {
    "sway/config".source = ../sway/config;
    "waybar".source = ../waybar;
  };

  programs.waybar = {
    enable = true;
    
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  home.sessionVariables = {
    PNPM_HOME = "$HOME/.local/share/pnpm";
  };

  home.sessionPath = [
    "$HOME/.local/share/pnpm/bin"
    "$HOME/.local/share/pnpm"
  ];

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
