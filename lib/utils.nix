{ lib, ... }:
let
  inherit (builtins) attrNames isAttrs readDir listToAttrs;

  inherit (lib) filterAttrs hasSuffix mapAttrs' nameValuePair removeSuffix;

  mapFilterAttrs = seive: f: attrs: filterAttrs seive (mapAttrs' f attrs);

  genAttrs' = values: f: listToAttrs (map f values);
in
{
  inherit mapFilterAttrs genAttrs';

  recImport = { dir, _import ? base: import "${dir}/${base}.nix" }:
    mapFilterAttrs
      (_: v: v != null)
      (n: v:
        if n != "default.nix" && hasSuffix ".nix" n && v == "regular"
	then
	  let name = removeSuffix ".nix" n; in nameValuePair (name) (_import name)
        else
          nameValuePair ("") (null))
      (readDir dir);

  pathsToImportedAttrs = paths:
    genAttrs' paths (path: {
      name = removeSuffix ".nix" (baseNameOf path);
      value = import path;
    });
}
