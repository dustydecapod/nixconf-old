# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./users/berz.nix
  ];

  options = {
    hostname = mkOption {
      type = types.str;
      default = "unnamed";
      example = "chewy";
      description = "hostname";
    };
  };

  config = {
    # Experimental Features
    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };

    security.polkit.enable = true;
    virtualisation.docker.enable = true;
    virtualisation.docker.enableNvidia = true;

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "${config.hostname}";
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Los_Angeles";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Greetd!
    services.greetd = {
      enable = true;
      settings = {
        default_session.command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --time \
            --asterisks \
            --user-menu \
            --cmd bash
        '';
      };
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      git
      curl
    ];

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 7860 ];
      allowedUDPPortRanges = [
      ];

    };

    programs.mtr.enable = true;
    system.stateVersion = "23.11"; # Did you read the comment?
  };
}
