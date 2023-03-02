{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.gossa;
in
{
  meta.maintainers = with maintainers; [ dsymbol ];

  options.services.gossa = {
    enable = mkEnableOption "A fast and simple multimedia fileserver";

    directory = mkOption {
      type = types.str;
      description = "Absolute path to share";
      example = "/home/user/share";
    };

    host = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "Host to listen to";
    };

    port = mkOption {
      type = types.str;
      default = "8001";
      description = "Port to listen to";
    };

    prefix = mkOption {
      type = types.str;
      default = "/";
      description = "URL prefix at which gossa can be reached";
      example = "/gossa/"; 
    };

    readOnly = mkOption {
      type = types.bool;
      default = false;
      description = "Read only mode (no upload, rename, move, etc...)";
    };

    followSymlinks = mkOption {
      type = types.bool;
      default = false;
      description = "Follow symlinks WARNING: symlinks will by nature allow to escape the defined path";
    };
  };

  config = mkIf cfg.enable {

    systemd.user = {
      services.gossa = {
        Unit = {
          Description = "A fast and simple multimedia fileserver";
          Wants = [ "network-online.target" ];
          After = [ "network-online.target" ];
        };

        Service = {
          Restart = "always";
          RestartSec = 30;

          ExecStart = ''
            ${pkgs.gossa}/bin/gossa \
              -h ${cfg.host} \
              -p ${cfg.port} \
              -prefix ${cfg.prefix} \
              ${if cfg.readOnly then "-ro" else ""} \
              ${if cfg.followSymlinks then "-symlinks" else ""} \
              "-verb" \
              ${cfg.directory}
          '';
        };

        Install.WantedBy = [ "default.target" ];
      };
    };

  };
}
