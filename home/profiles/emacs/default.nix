{ config, options, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.emacs;
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

      extraPackages = epkgs: (with epkgs.elpaPackages; [
        delight
      ]) ++ (with epkgs.melpaPackages; [
        use-package
        which-key
        avy
        counsel
        projectile
        counsel-projectile
        magit
	      hydra
	      spacemacs-theme
	      moe-theme
	      material-theme
	      nix-mode
	      gitignore-mode
	      gitconfig-mode
	      treemacs
        treemacs-projectile
        treemacs-magit
      ]) ++ (with epkgs.orgPackages; [
        org-plus-contrib
      ]);
    };

    home.packages = with pkgs; [
      python3
      clang-tools
    ];

    home.file.".emacs.d/init.el".source = ./init.el;

    home.file.".emacs.d/fe-locations.el".text = ''
      (defconst fe/locs
        '(python3 "${pkgs.python3}/bin/python3"
          clangd "${pkgs.clang-tools}/bin/clangd"))
      (defun fe/get-loc (sym)
        (plist-get fe/locs sym))
      (defmacro fe/get-locq (sym)
        `(fe/get-loc ',sym))

      (provide 'fe-locations)
    '';
  };
}
