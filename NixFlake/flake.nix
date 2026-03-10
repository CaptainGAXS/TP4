{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    outputs =
    inputs:
    let
    # This function helps to create packages for all supported systems.
    # Find documentation at:
    # - https://noogle.dev/f/lib/genAttrs
    forAllSystems =
    fn:
    inputs.nixpkgs.lib.genAttrs inputs.nixpkgs.lib.systems.flakeExposed (
    system:
    fn (
    import inputs.nixpkgs {
    inherit system;
    }
    )
    );
    in
    {
    packages = forAllSystems (pkgs: {
    montecarlo-pi = pkgs.stdenv.mkDerivation {
    name = "montecarlo-pi";

    src = ./src;

    buildPhase = ''
    $CC montecarlo-pi.c -o montecarlo-pi
    '';

    installPhase = ''
    install -D montecarlo-pi $out/bin/montecarlo-pi
    '';

    meta.mainProgram = "montecarlo-pi";
    };
    });
    };
}
