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
        general = {
          config = ''
            (with-eval-after-load 'evil
              (progn
                (general-define-key
                 :states 'motion
                 ";" #'evil-ex
                 ":" #'evil-repeat-find-char)
                (general-create-definer my-leader-def
                  :states '(normal insert motion visual emacs)
                  :keymaps 'override
                  :prefix "SPC"
                  :non-normal-prefix "M-SPC")
                (my-leader-def
                  "SPC" '(counsel-M-x :which-key "M-x")

                  "f" '(:ignore t :which-key "file")
                  "ff" '(find-file :which-key "find")
                  "fw" '(write-file :which-key "write")
                  "fr" '(rename-file :which-key "rename")
                  "fd" '(delete-file :which-key "delete")

                  "fe" '(:ignore t :which-key "emacs")
                  "fer" '(my-init-load :which-key "reload")
                  "fec" '(my-init-edit :which-key "edit")

                  "r" '(:ignore t :which-key "frame")
                  "rr" '(make-frame :which-key "new")
                  "rf" '(find-file-other-frame :which-key "find file")
                  "rq" '(delete-frame :which-key "delete")

                  "w" '(:ignore t :which-key "window")
                  "wq" '(delete-window :which-key "delete")
                  "wd" '(kill-buffer-and-window :which-key "delete buffer and window")

                  "wh" '(windmove-left :which-key "left")
                  "wl" '(windmove-right :which-key "right")
                  "wj" '(windmove-down :which-key "down")
                  "wk" '(windmove-up :which-key "up")

                  "w=" '(balance-windows :which-key "balance")
                  "w/" '(split-window-horizontally :which-key "split horizontal")
                  "w-" '(split-window-vertically :which-key "split vertical")

                  "b" '(:ignore t :which-key "buffer")
                  "bb" '(ivy-switch-buffer :which-key "switch")
                  "bh" '(previous-buffer :which-key "previous")
                  "bl" '(next-buffer :which-key "next")
                  "bq" '(kill-current-buffer :which-key "kill current buffer")

                  "g" '(:ignore t :which-key "git"))))
          '';
    };

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
