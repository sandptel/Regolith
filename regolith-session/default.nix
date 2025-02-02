
{pkgs,...}:
# let
#   nixpkgs = builtins.fetchTarball {
#     url = "https://github.com/NixOS/nixpkgs/archive/nixos-24.05.tar.gz";
#   };

#   pkgs = import nixpkgs { config = {}; };
# in

pkgs.stdenv.mkDerivation {
  pname = "regolith-session";
  version = "3.1";
  
  # src = ./.;
  src = pkgs.fetchFromGitHub {
    owner = "regolith-linux";
    repo = "regolith-session";
    rev = "r3_2";
    hash = "sha256-4bKLcN6+JFD2Ogom3O9nGk16J5pysU/9cyuLe9LfBEs=";
  };

  nativeBuildInputs = [

  ];

  buildInputs = with pkgs;[
    
  ];

  buildPhase = ''
  # chmod -R +x $src
  patchShebangsAuto $src
  '';

   installPhase = ''
    # Install your scripts or binaries
    
    mkdir -p $out
    cp -r $src/usr $out
  
    mkdir -p $out/etc
    cp -r $src/etc $out

    mkdir -p $out/bin
    cp -r $src/usr/bin $out

    substituteInPlace $out/bin/* \
    --replace-quiet /usr/lib/systemd /run/current-system/sw/lib/systemd \

    substituteInPlace $out/bin/* \
    --replace-quiet /usr /run/current-system/sw/usr \
    --replace-quiet /etc /run/current-system/sw/etc \

    substituteInPlace $out/usr/lib/regolith/* \
    --replace-quiet /usr /run/current-system/sw/usr \
    --replace-quiet /etc /run/current-system/sw/etc \

  '';

  # postInstall = ''
  
    # pathsToLink = [ /bin /usr /lib];

  #   # --replace-fail "a string containing spaces" "some other text" \
  #   # --subst-var someVar
  # '';

  meta = {
    # mainProgram = "";
    description = "Session files and Executables";
    homepage = "https://github.com/regolith-linux/regolith-session";
    license = pkgs.lib.licenses.gpl3Plus;
  };
}
