{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # agenix.url = "github:ryantm/agenix";
    # agenix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, sops-nix, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations = {
    	tomo-nix = nixpkgs.lib.nixosSystem {
    		inherit system;
    		modules = [
    			./nixos/configuration.nix
    			# agenix.nixosModules.default
    			sops-nix.nixosModules.sops
    		];
    	};
    };
    devShells.${system}.sops = pkgs.mkShell {
    	packages = [ pkgs.sops ];
    	SOPS_AGE_KEY_FILE = "/var/lib/sops/key.txt";
    };
  };
}
