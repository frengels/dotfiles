{ config, options, lib, pkgs, ... }:
with lib;
let cfg = config.profiles.emacs;
in {
  options = {
    profiles.emacs = {
      enable = mkEnableOption "emacs";

      package = mkOption {
        type = types.package;
        default = pkgs.emacs;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = cfg.package;

      extraPackages = epkgs:
        (with epkgs.elpaPackages; [ delight ]) ++ (with epkgs.melpaPackages; [
          use-package
          which-key
          avy
          ivy
          counsel
          swiper
	  direnv
          projectile
          counsel-projectile
          magit
          format-all
          hydra
          spacemacs-theme
          moe-theme
          material-theme
          doom-themes
          leuven-theme
          nix-mode
          gitignore-mode
          gitconfig-mode
          gitattributes-mode
          treemacs
          treemacs-projectile
          treemacs-magit
          smooth-scrolling

          evil
          evil-collection
          evil-magit

          key-chord

          company

          ripgrep
          flycheck
          git-commit
          yasnippet
          smartparens
          ace-window
          goto-chg
          powerline
          doom-modeline
          flx

          markdown-mode
          rust-mode

          lsp-mode
          lsp-ui
          golden-ratio
          git-timemachine
        ]) ++ (with epkgs.orgPackages; [ org-plus-contrib ]);
    };

    home.packages = with pkgs; [
      python3
      clang-tools
      cmake
      nixfmt
      cmake-format
    ];

    home.file.".emacs.d/init.el".source = ./init.el;
  };
}
