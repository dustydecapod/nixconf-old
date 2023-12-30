{
  description = "Zoidbb's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      "chewy" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [       
          ./hosts/chewy.nix
          ./common.nix {
            hostname = "chewy";
          }
          ./xserver.nix
        ];
      };

      "mort" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [       
          ./hosts/mort.nix
          ./common.nix {
            hostname = "mort";
          }
          ./xserver.nix
        ];
      };
    };
  };
}
