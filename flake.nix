{
  description = "Ryan's NixOS Flake";

  inputs = {
    Hyprland.url = "https://flakehub.com/f/hyprwm/Hyprland/0.33.1.tar.gz";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/*.tar.gz";
  };

  outputs = { self, nixpkgs, fh, Hyprland, home-manager, ... }@inputs: {
    nixosConfigurations = {
      "chewy" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [

          # Flakehub
          {
            environment.systemPackages = [
              fh.packages.x86_64-linux.default
            ];
          }

          # Home-Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.berz = import ./users/berz.nix;
          }
            
          ./configuration.nix
        ];
      };
    };
  };
}
