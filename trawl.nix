{lib,rustPlatform,fetchFromGitHub,pkg-config,glib,rustc,}:

rustPlatform.buildRustPackage {
  pname = "trawl";
  version = "3.1";

  src = fetchFromGitHub {
    owner = "sandptel";
    repo = "trawl";
    rev = "master";
    hash = "sha256-A50ndcKdXQssL3SRG3INpU/8XelbPx3XlgJ/LdN2RUU=";
  };

cargoHash = "sha256-Nnc+j7mBRibPr33mOb9PvMq4lula23iZCuUqB+FLaAY=";

buildInputs = [ glib pkg-config ];

  meta = {
    mainProgram = "trawl";
    description = "Simple Xresources style linux based configuration system that is independent of distro / display backend (Wayland / X11 / etc).";
    homepage = "https://github.com/regolith-linux/trawl";
    license = lib.licenses.gpl3Plus;
  };
  
}