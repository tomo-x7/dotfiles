{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, sops-nix, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    homenix = ./nixos/home.nix;
  in
  {
    nixosConfigurations = {
    	tomo-nix = nixpkgs.lib.nixosSystem {
    		inherit system;
    		modules = [
    			./nixos/configuration.nix
    			sops-nix.nixosModules.sops
    			home-manager.nixosModules.home-manager
    			{
    			  home-manager.useGlobalPkgs = true;
    			  home-manager.useUserPackages = true;
    			  home-manager.users.tomo = import homenix;
    			}
    		];
    	};
    };
    homeConfigurations.tomo = home-manager.lib.homeManagerConfiguration {
      modules = [ (import homenix) ];
    };
    devShells.${system}.sops = pkgs.mkShell {
    	packages = [ pkgs.sops ];
    	SOPS_AGE_KEY_FILE = "/var/lib/sops/key.txt";
    };
  };
}
