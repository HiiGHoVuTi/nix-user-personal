{ kakoune
, lib
, pkgs
, ...
} @ args: 
let
  config = pkgs.writeTextFile (rec {
    name = "kakrc.kak";
    destination = "/share/kak/autoload/${name}";
    text = ''
    '';
  });
in
{
  programs.kakoune = {
    enable = true;
    plugins = with pkgs.kakounePlugins; [
      pkgs.kak-lsp
    ];
  };
}
