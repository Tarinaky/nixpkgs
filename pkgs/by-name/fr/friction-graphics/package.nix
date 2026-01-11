{
  appimageTools,
  fetchurl,
  lib,
  pkgs,
}:
let
  pname = "friction-graphics";
  version = "1.0.0-rc.3";

  src = fetchurl {
    url = "https://github.com/friction2d/friction/releases/download/v1.0.0-rc.3/Friction-${version}-x86_64.AppImage";
    hash = "sha256-MV+JoAtYG+06P1SDl4GarjxqevKNf5ycyiFb5LCYGss=";
  };
  extracted = pkgs.appimageTools.extractType2 { inherit src pname version; };

in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -Dm444 ${extracted}/graphics.friction.Friction.desktop \
      $out/share/applications/graphics.friction.Friction.desktop

    install -Dm644 ${extracted}/graphics.friction.Friction.png \
      $out/share/icons/hicolor/256x256/apps/graphics.friction.Friction.png

    mv $out/bin/friction-graphics $out/bin/friction
  '';

  meta = with lib; {
    description = "A powerful and versatile motion graphics application that allows you to create vector and raster animations for web and video.";
    homepage = "https://friction.graphics/";
    license = licenses.gpl3;
    maintainers = with maintainers; [ tarinaky ];
    platforms = [ "x86_64-linux" ];
  };
}
