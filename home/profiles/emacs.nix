{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.emacs;
in {
  options = {
    profiles.emacs.enable = mkEnableOption "emacs";

    profiles.emacs.package = mkOption {
      type = types.package;
      default = pkgs.emacsGcc;
    };
  };

  config = mkIf cfg.enable {
    programs.my-emacs = {
      enable = true;
      package = cfg.package;

      settings = {
        magit = {
          config = ''
            (with-eval-after-load 'general
              (my-leader-def
                "gs" '(magit-status :which-key "magit status")))
          '';
	};

        company = {
	  defer = 3;
	  config = ''
            (setq company-minimum-prefix-length 1)
            (with-eval-after-load 'general
              (general-define-key
               "TAB" 'company-ident-or-complete-common))
          '';
        };
      };
    };
  };
}
