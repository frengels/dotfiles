{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.emacs2;
in {
  options = {
    profiles.emacs2 = {
      enable = mkEnableOption "emacs";

      package = mkOption {
        type = types.package;
	default = pkgs.emacs;
	description = "Emacs package to install";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      clang-tools
    ];

    programs.emacs = {
      enable = true;
      package = cfg.package;

      extraPackages = epkgs: with epkgs; [
        build-farm
        company-nixos-options
	nix-mode
	nix-update
	nixos-options
	nixpkgs-fmt

        delight
	use-package
	which-key
	paredit
	evil-paredit
	lispy
	evil
	evil-collection
	evil-escape
	general
	golden-ratio
	org-plus-contrib
	org-journal
	org-bullets
	evil-org
	clang-format
	modern-cpp-font-lock
	magit
	forge
	magit-gh-pulls
	magit-gitflow
	evil-magit
	git-commit
	git-timemachine
	gitignore-mode
	ivy
	ivy-xref
	ivy-rich
	swiper
	avy
	ace-window
	ace-jump-mode
	projectile
	all-the-icons
	all-the-icons-ivy
	geiser
	powerline
	moe-theme
	company
	company-quickhelp
	company-box
	company-lsp
      ];

      overrides = final: prev: {};
    };

    # home.file.".emacs.d
  };
}