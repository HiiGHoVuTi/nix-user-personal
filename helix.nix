{ helix
, lib
, pkgs
, ...
} @ args: {
  programs.helix = {
    enable = true;
    package = helix.packages.${pkgs.system}.helix;

    languages = [ 
      { 
        name = "clojure";
        indent = { tab-width=2; unit="tab"; }; 
      } 
    ];

    settings = {
      theme = "catppuccin_mocha";
      editor = {
        # true-color = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker.hidden = false;
      };

      keys.insert.right = "move_char_right";
      keys.insert.left = "move_char_left";
      keys.insert.down = "move_line_down";
      keys.insert.up = "move_line_up";
      keys.normal.a = "insert_mode";
      keys.normal.space.u = {
        f = ":format"; # format using LSP formatter
      };
    };

    themes =
      let
        catppuccin-helix = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "helix";
          rev = "dc1d236f610fa9573fa59194c79dd3a5a9c8a639";
          sha256 = "sha256-JfTS1Kgcdd/Gu05QXWwztHlr9zrIy73YXLvx7iaYAqM=";
        };

        variants = [ "catppuccin_latte" "catppuccin_frappe" "catppuccin_macchiato" "catppuccin_mocha" ];
      in
      lib.genAttrs variants (n: builtins.fromTOML (builtins.readFile "${catppuccin-helix}/italics/${n}.toml"));
  };
}
