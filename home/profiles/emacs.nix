{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.emacs;
in {
  options = {
    profiles.emacs.enable = mkEnableOption "emacs";

    profiles.emacs.package = mkOption {
      type = types.package;
      default = pkgs.emacs;
    };
  };

  config = mkIf cfg.enable {
    programs.my-emacs = {
      enable = true;
      package = cfg.package;

      settings = {
        moe-theme = {
          config = ''
            (moe-dark)
          '';
        };

	which-key = {
          config = ''
            (which-key-mode t)
          '';
	};

	direnv = {
          config = ''
            (direnv-mode)
	  '';
	};

        evil = {
          commands = [ "evil-mode" ];
          init = ''
            (setq evil-want-integration t
  	              evil-want-keybinding nil)
            (evil-mode)
          '';
        };
  
        evil-collection = {
          after = [ "evil" ];
          config = ''
            (evil-collection-init)
          '';
        };
  
        evil-escape = {
          after = [ "evil" ];
          init = ''
            (setq-default evil-escape-key-sequence (kbd "fd"))
            (setq-default evil-escape-delay 0.125)
          '';
          config = ''
            (evil-escape-mode)
          '';
        };
  
        evil-surround = {
          after = [ "evil" ];
          config = ''
            (global-evil-surround-mode 1)
          '';
        };

        general = {
          config = ''
              (progn
                (general-define-key
                 :states 'motion
                 ";" #'evil-ex
                 ":" #'evil-repeat-find-char)
                (general-create-definer my-leader-def
                  :states '(normal insert emacs)
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

                  "g" '(:ignore t :which-key "git")))
          '';
        };

        magit = {
          config = ''
            (with-eval-after-load 'general
              (my-leader-def
                "gs" '(magit-status :which-key "magit status")))
          '';
        };

        forge = {
          after = [ "magit" ];
        };

        magit-gh-pulls = {
          enable = false;

          after = [ "magit" ];
          hook = [
            { magit-mode = "turn-on-magit-gitflow"; }
          ];
        };

        company = {
          defer = 3;
	  hook = [
            { after-init = "global-company-mode"; }
	  ];
          config = ''
            (setq company-minimum-prefix-length 1)
            (with-eval-after-load 'general
              (general-define-key
               "TAB" 'company-ident-or-complete-common))
          '';
        };

        org-bullets = {
          hook = [ 
            { org-mode = "org-bullets-mode"; }
          ];
        };

        modern-cpp-font-lock = {
          hook = [
            { "c++-mode" = "modern-c++-font-lock-mode"; }
          ];
        };

	ivy = {
          config = ''
            (setq ivy-height 20)
            (setq ivy-use-virtual-buffers t)
            (setq enable-recursive-minibuffers t)
            (setq ivy-display-style 'fancy)
            (ivy-mode t)
            (with-eval-after-load 'projectile
              (setq projectile-completion-system 'ivy))
          '';
	};

	ivy-xref = {
          init = ''
            (setq xref-show-xrefs-function #'ivy-xref-show-xrefs)
          '';
	};

	counsel = {
          after = [ "ivy" ];
	  config = ''
            (counsel-mode)
          '';
	};

	ivy-rich = {
          after = [ "ivy" ];
         config = ''
            (ivy-rich-mode t)
          '';
	};

	swiper = {
          after = [ "ivy" ];
	  init = ''
            (global-unset-key (kbd "C-s"))
          '';
	  config = ''
            (with-eval-after-load 'evil
              (with-eval-after-load 'general
                (general-define-key
                 :states 'motion
                 "/" #'swiper)))
          '';
	};

	lsp-mode = {
          commands = [ "lsp" ];
	  hook = [
            { rust-mode = "lsp"; }
	  ];
          init = ''
            (setq lsp-prefer-flymake nil)
          '';
          config = ''
            (require 'lsp-clients)
            (with-eval-after-load 'general
              (my-leader-def
                "l" '(:ignore t :which-key "lsp")
                "lr" '(lsp-rename :which-key "rename")
                "lf" '(:ignore t :which-key "find")
                "lfd" '(lsp-find-definition :which-key "definition")
                "lfD" '(lsp-find-declaration :which-key "declaration")))
          '';
	};

	lsp-ui = {
          hook = [
            { lsp-mode = "lsp-ui-mode"; }
	  ];

          init = ''
            (setq lsp-ui-flycheck-enable t)
          '';

          config = ''
            (with-eval-after-load 'general
              (my-leader-def
                "lu" '(:ignore t :which-key "lsp-ui")))
          '';
 	};

	clang-format = {
	  enable = false; # failing to download
          extraPackages = [ pkgs.clang-tools ];
	};

	rust-mode = {
          hook = [
            { rust-mode = "cargo-minor-mode"; }
	  ];
	};

	flycheck = {
          config = ''
            ; (global-flycheck-mode)
            (with-eval-after-load 'general
              (my-leader-def
                "c" '(:ignore t :which-key "flycheck")
                "cj" '(flycheck-next-error :which-key "next error")
                "ck" '(flycheck-previous-error :which-key "prev error")
                "cl" '(flycheck-list-errors :which-key "list errors")))
          '';
	};
      };
    };
  };
}
