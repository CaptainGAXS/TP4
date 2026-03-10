{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    outputs = inputs: {
        devShells.x86_64-linux.default =
        let
            pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        in
        pkgs.mkShell {
            packages = [
                pkgs.gcc
                pkgs.python3
                pkgs.podman
            ];
        };
    };
}
