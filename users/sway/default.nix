{ config, lib, pkgs, ... }:
let
  cfg = config.wayland.windowManager.sway;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      source-code-pro
    ];
    wayland.windowManager.sway = {
      systemdIntegration = true;

      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland-egl
        export CLUTTER_BACKEND=wayland
        export BEMENU_BACKEND=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
      config = {
        terminal = "${pkgs.termite}/bin/termite";
        menu = "${pkgs.bemenu}/bin/bemenu-run";
        modifier = "Mod4";
        keybindings = let cfg = config.wayland.windowManager.sway.config; mod = cfg.modifier; in {

          #"XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 5";
          #"XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 5";

          "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";

          "${mod}+Return" = "exec ${cfg.terminal}";
          "${mod}+Shift+q" = "kill";
          "${mod}+d" = "exec ${cfg.menu}";

          "${mod}+${cfg.left}" = "focus left";
          "${mod}+${cfg.down}" = "focus down";
          "${mod}+${cfg.up}" = "focus up";
          "${mod}+${cfg.right}" = "focus right";

          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          "${mod}+Shift+${cfg.left}" = "move left";
          "${mod}+Shift+${cfg.down}" = "move down";
          "${mod}+Shift+${cfg.up}" = "move up";
          "${mod}+Shift+${cfg.right}" = "move right";

          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          "${mod}+b" = "splith";
          "${mod}+v" = "splitv";
          "${mod}+f" = "fullscreen";
          "${mod}+a" = "focus parent";
          
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";

          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";

          "${mod}+0" = "workspace number 0";
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";

          "${mod}+Shift+minus" = "move scratchpad";
          "${mod}+minus" = "scratchpad show";

          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+e" = 
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

          "${mod}+r" = "mode resize";
        };
        input = {
          "1739:0:Synaptics_TM3384-001" = {
            tap = "enabled";
            natural_scroll = "enabled";
          };
          "2:7:SynPS/2_Synaptics_TouchPad" = {
            tap = "enabled";
            natural_scroll = "enabled";
          };
          "*" = {
            xkb_layout = "us";
            xkb_options = "ctrl:nocaps";
          };
        };
        output = {
          "DVI-D-1" = {
            resolution = "1920x1080";
            position = "0,0";
          };
          "HDMI-A-1" = {
            resolution = "1920x1080";
            position = "1920,0";
          };
        };
        fonts = [ "Source Code Pro 10" ];

        gaps = {
          bottom = 5;
          horizontal = 5;
          vertical = 5;
          inner = 5;
          left = 5;
          outer = 5;
          right = 5;
          top = 5;
          smartBorders = "on";
          smartGaps = true;
        };

        window = {
          titlebar = true;
        };

	bars = [
	  {
	    id = "bar-top";
	    mode = "dock";
            position = "top";
	    workspaceButtons = true;
	  }
	];
      };
    };
  };
}
