{ config, pkgs, ... }:
{
  users.users.berz = {
  isNormalUser = true;
  description = "Ber Zoidberg";
  extraGroups = [ "networkmanager" "wheel" ];
  packages = with pkgs; [
    firefox
    discord
    spotify
    vscode
    zsh
    ];
  };
}