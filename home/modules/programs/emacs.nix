{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.my-emacs;

  emacsPackages = 
    let epkgs = pkgs.emacsPackagesFor cfg.package;
  in epkgs.overrideScope' cfg.overrides;

  emacsWithPackages = emacsPackages.emacsWithPackages;

  packagesFromSettings = epkgs:
    mapAttrsToList (n: v: epkgs.${n}) (filterAttrs (n: v: v.enable == true) (cfg.settings));

  requiredPackages = epkgs: [ epkgs.use-package ];
  combinedPackages = epkgs: (cfg.extraPackages epkgs) ++ (packagesFromSettings epkgs) ++ (requiredPackages epkgs);

  allExtraPackages = (foldl (a: b: a ++ b) [] (mapAttrsToList (n: v: v.extraPackages) cfg.settings));

  packageSpec = { config, name, ... }:
  {
    options = with lib; {
      enable = mkEnableOption "this package" // {
        default = true;
      };

      name = mkOption {
        type = types.str;
	default = name;
      };

      extraPackages = mkOption {
        type = types.listOf types.package;
	default = [];
      };

      defer = mkOption {
        type = types.either types.bool types.ints.unsigned;
	default = false;
      };

      after = mkOption {
        type = types.listOf types.str;
	default = [];
      };

      commands = mkOption {
        type = types.listOf types.str;
	default = [];
      };

      hook = mkOption {
        type = types.listOf (types.addCheck
	  (types.attrsOf types.str)
	  (e: builtins.length (builtins.attrNames e) == 1));
	default = [];
      };

      init = mkOption {
        type = types.str;
	default = "";
	description = "The elisp code to execute before the package is loaded";
      };

      config = mkOption {
        type = types.str;
	default = "";
	description = "The elisp code to execute after the package is loaded";
      };
    };
  };

  makeElisp = { enable, name, defer, after, commands, hook, init, config, ... }: 
    let
      # prefixes each line with the given prefix
      indentLinesWith = 
        s: prefix: 
	  builtins.concatStringsSep "\n" (map (s: (if (s == "") then "" else (prefix + s)))
	                     (splitString "\n" s));
      # indent each line by 2 and remove trailing \n, this will make it look better in the config
      prettifyCode = s: removeSuffix "\n" (indentLinesWith s "  ");

      toSexpr = l: 
        let
          len = builtins.length l;
	in 
	(if (len == 0) then
	  "()"
	else
	  (if (len == 1) then
	    (concatStrings l)
	  else
	    ("(" + (builtins.concatStringsSep " " l) + ")")));

      attrs = {
        name = (assert ! hasInfix " " name; name);
        disabled = optionalString (! enable) "\n  :disabled";
        defer = 
	  if (builtins.isBool defer) then
	    (optionalString defer "\n  :defer t")
	  else
	    "\n  :defer ${toString defer}";

	after =
	  let
	    prefix = "\n  :after ";
	    len = builtins.length after;
	  in optionalString (len != 0)
	    (prefix + (toSexpr after));

        commands =
	  let
	    prefix = "\n  :commands ";
	    len = builtins.length commands;
	  in optionalString (len != 0)
	    (prefix + (toSexpr commands));
	
	hook =
	  let
	    attrToCons = attr:
	      let
	        car = builtins.head (builtins.attrNames attr);
		cdr = builtins.head (builtins.attrValues attr);
	      in "(${car} . ${cdr})";
	    mapConsString = l:
	      concatMapStringsSep "\n" attrToCons hook;

	    prefix = "\n  :hook\n";
	    len = builtins.length hook;
	  in optionalString (len != 0)
	    (prefix + (prettifyCode (mapConsString hook)));


	init = optionalString (init != "") 
	  ("\n  :init\n" + (prettifyCode init));

	config = optionalString (config != "")
	  ("\n  :config\n" + (prettifyCode config));
      };

      finalStr = concatStrings [
        attrs.name
	attrs.disabled
	attrs.defer
	attrs.after
	attrs.commands
	attrs.hook
	attrs.init
	attrs.config
      ];
    in "(use-package ${finalStr})";

  settingsToElisp = mapAttrsToList (_: v: makeElisp v) cfg.settings;
in {
  options = {
    programs.my-emacs = {
      enable = mkEnableOption "emacs";

      package = mkOption {
        type = types.package;
	default = pkgs.emacs;
      };

      overrides = mkOption {
        type = types.unspecified; # TODO use home-manager overlayFunction
	default = final: prev: { };
	description = "Allows overriding packages within the emacs package set";
      };

      settings = mkOption {
        type = types.attrsOf (types.submodule packageSpec);
	default = {};
      };

      extraPackages = mkOption {
        type = types.unspecified;
	default = epkgs: [];
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      (emacsWithPackages combinedPackages)
    ] ++ allExtraPackages;

    home.file.".emacs.d/init.el" = {
      text = ''
        (eval-when-compile
          (require 'use-package))

      '' + (builtins.concatStringsSep "\n\n" settingsToElisp);
    };

    /*
    xdg.configFile."emacs/init.el" = {
      text = ''
        (eval-when-compile
          (require 'use-package))

      '' + (builtins.concatStringsSep "\n\n" settingsToElisp);
    };
    */
  };
}
