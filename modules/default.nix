{ config, options, lib, ... }:
with lib;
let
  mkOptionStr = value:
    mkOption {
      type = types.str;
      default = value;
    };
in {
  imports = [
    <home-manager/nixos>

    ./desktop
    ./dev
    ./editors
    ./media
    ./services
    ./shell
    ./themes
  ];

  options = {
    my = {
      ## Personal details
      username = mkOptionStr "emiller";
      email = mkOptionStr "edmund.a.milller@gmail.com";

      ## Convenience aliases
      home =
        mkOption { type = options.home-manager.users.type.functor.wrapped; };
      user = mkOption { type = types.submodule; };
      packages = mkOption { type = with types; listOf package; };

      ## Environment
      env = mkOption {
        type = with types;
          attrsOf (either (either str path) (listOf (either str path)));
        apply = mapAttrs (n: v:
          if isList v then
            concatMapStringsSep ":" (x: toString x) v
          else
            (toString v));
      };

      alias = mkOption {
        type = with types; nullOr (attrsOf (nullOr (either str path)));
      };
      zsh = {
        rc = mkOption {
          type = types.lines;
          default = "";
          description = ''
            Zsh lines to be written to $XDG_CONFIG_HOME/zsh/extra.zshrc and
            sourced by $XDG_CONFIG_HOME/zsh/.zshrc
          '';
        };
        env = mkOption {
          type = types.lines;
          default = "";
          description = ''
            Zsh lines to be written to $XDG_CONFIG_HOME/zsh/extra.zshenv and
            sourced by $XDG_CONFIG_HOME/zsh/.zshenv
          '';
        };
      };
    };
  };

  config = {
    ## Convenience aliases
    home-manager.users.${config.my.username} =
      mkAliasDefinitions options.my.home;
    users.users.${config.my.username} = mkAliasDefinitions options.my.user;
    my.user.packages = config.my.packages;

    ## PATH should always start with its old value
    my.env.PATH = [ <bin> "$PATH" ];
    environment.extraInit = let
      exportLines = mapAttrsToList (n: v: ''export ${n}="${v}"'') config.my.env;
    in ''
      export XAUTHORITY=/tmp/Xauthority
      [ -e ~/.Xauthority ] && mv -f ~/.Xauthority "$XAUTHORITY"

      ${concatStringsSep "\n" exportLines}
          '';

    # I avoid programs.zsh.*Init variables because they initialize too soon. My
    # zsh config is particular about load order.
    my.home.xdg.configFile = {
      "zsh/extra.zshrc".text = let
        aliasLines =
          mapAttrsToList (n: v: ''alias ${n}="${v}"'') config.my.alias;
      in ''
        # This file is autogenerated, do not edit it!
        ${concatStringsSep "\n" aliasLines}
        ${config.my.zsh.rc}
      '';
      "zsh/extra.zshenv".text = ''
        # This file is autogenerated, do not edit it!
        ${config.my.zsh.env};
      '';
    };
  };
}
