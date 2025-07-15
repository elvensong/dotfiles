{
	description = "My shared Nix configuration for multiple machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      homeConfigurations = {
        # Your Work Laptop
        work = home-manager.lib.homeManagerConfiguration {
          inherit system;
          username = "your-username";
          homeDirectory = "/home/eve";
          configuration = import ./hosts/work.nix;
        };

        # Your Personal PC
        personal = home-manager.lib.homeManagerConfiguration {
          inherit system;
          username = "your-username";
          homeDirectory = "/home/eve";
          configuration = import ./hosts/personal.nix;
        };
      };
    };
}

