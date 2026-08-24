# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:
let
  ageKeyFile = "/var/lib/sops/key.txt";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tomo-nix"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager = {
  	enable = true;
    ensureProfiles = {
      environmentFiles = [
        config.sops.secrets."wifi-env".path
      ];
      profiles = {
        "Home-WiFi" = {
          connection = {
            id = "Home-WiFi";
            type = "wifi";
          };
          wifi = {
            mode = "infrastructure";
            ssid = "$WIFI_HOME_SSID";
          };
          wifi-security = {
            auth-alg = "open";
            key-mgmt = "wpa-psk";
            psk = "$WIFI_HOME_PSK";
          };
        };
        "MMA-WiFi" = {
          connection = {
            id = "MMA-WiFi";
            type = "wifi";
          };
          wifi = {
            mode = "infrastructure";
            ssid = "$WIFI_MMA_SSID";
          };
          wifi-security = {
            key-mgmt = "wpa-eap";
          };
          "802-1x" = {
            eap = "peap";
            identity = "$WIFI_MMA_USERNAME";
            phase2-auth = "mschapv2";
            password = "$WIFI_MMA_PASSWORD";
          };
        };
      };
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "jp106";
    #useXkbConfig = true; # use xkb.options in tty.
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "jp";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tomo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    libreoffice
    firefox
    micro
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  sops = {
  	age.keyFile = ageKeyFile;
  	defaultSopsFile = ./secrets/secrets.yaml;
    secrets = {
      "wifi-env" = {};
    };
  };

  environment.sessionVariables = {
    EDITOR = "micro";  	
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
