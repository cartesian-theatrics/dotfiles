{ config, options, lib, pkgs, ... }:
with lib; {
  imports = [
    ./emacs.nix
    ./kakoune.nix
    ./vim.nix
    # ./vscode.nix
  ];

  options.modules.editors = {
    default = mkOption {
      type = types.str;
      default = "vi";
    };
  };

  config = mkIf (config.modules.editors.default != null) {
    my.env.EDITOR = config.modules.editors.default;
  };
}
