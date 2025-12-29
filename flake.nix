{
    description = "Blockscout environment";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    outputs = {
        self,
        nixpkgs,
    }: let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
        };
    in {
        devShells.${system}.default = pkgs.mkShell {
            name = "blockscout-dev";
            buildInputs = with pkgs; [
                rustc
                cargo
                openssl
                pkg-config
            ];
            shellHook = ''
                echo "Entered Blockscout development shell";
            '';
        };
        MICROSERVICE_SC_VERIFIER_ENABLED = true;
        MICROSERVICE_SC_VERIFIER_URL = "http://0.0.0.0:8050/";
    };
}

