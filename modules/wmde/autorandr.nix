{ config, lib, pkgs, ... }:

{
  services.autorandr = {
    enable = true;
    defaultTarget = "main";
  };

  home-manager.users.emiller.programs.autorandr = {
    enable = true;
    hooks = {
      postswitch = {
        # "notify-i3" = "${pkgs.i3}/bin/i3-msg restart";
        # "change-background" = readFile ./change-background.sh;
        "change-dpi" = ''
          case "$AUTORANDR_CURRENT_PROFILE" in
            mobile)
              DPI=96
              ;;
            home-dual)
              DPI=164
              ;;
            home-single)
              DPI=164
              ;;
            *)
              echo "Unknown profle: $AUTORANDR_CURRENT_PROFILE"
              exit 1
          esac

          echo "Xft.dpi: $DPI" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
        '';
        "change-font" = ''
          case "$AUTORANDR_CURRENT_PROFILE" in
            mobile)
              FONTSIZE=13
              ;;
            home-dual)
              FONTSIZE=18
              ;;
            home-single)
              FONTSIZE=18
              ;;
            *)
              echo "Unknown profle: $AUTORANDR_CURRENT_PROFILE"
              exit 1
          esac

          echo "*font: xft:iosevka:size=$FONTSIZE" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
        '';
        "change-cursor" = ''
          case "$AUTORANDR_CURRENT_PROFILE" in
            mobile)
              CURSOR=32
              ;;
            home-dual)
              CURSOR=64
              ;;
            home-single)
              CURSOR=64
              ;;
            *)
              echo "Unknown profle: $AUTORANDR_CURRENT_PROFILE"
              exit 1
          esac

          echo "Xcursor.size: $CURSOR" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
        '';
      };
    };
    profiles = {
      home-dual = {
        fingerprint = {
          DP-0 =
          "00ffffffffffff000daee71500000000081b0104952213780228659759548e271e505400000001010101010101010101010101010101b43b804a713834405036680058c11000001acd27804a713834405036680058c11000001a00000000000000000000000000000000000000000002000c47ff0b3c6e1314246e00000000b6";
          DP-1 =
          "00ffffffffffff001e6d095b84dc0700051c0104b53c22789f3035a7554ea3260f50542108007140818081c0a9c0d1c08100010101014dd000a0f0703e803020650c58542100001a286800a0f0703e800890650c58542100001a000000fd00283d878738010a202020202020000000fc004c4720556c7472612048440a2001d80203117144900403012309070783010000023a801871382d40582c450058542100001e565e00a0a0a029503020350058542100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c8";
          HDMI-0 =
          "00ffffffffffff001e6d085b2d3a0000031c0103803c2278ea3035a7554ea3260f50542108007140818081c0a9c0d1c081000101010108e80030f2705a80b0588a0058542100001e04740030f2705a80b0588a0058542100001a000000fd00383d1e873c000a202020202020000000fc004c4720556c7472612048440a2001a7020330714d902220050403020161605d5e5f230907076d030c001000b83c20006001020367d85dc401788003e30f0006023a801871382d40582c450058542100001a565e00a0a0a029503020350058542100001a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa";
        };
        config = {
          DP-0 = { enable = false; };
          DP-2 = { enable = false; };
          DP-3 = { enable = false; };
          DP-4 = { enable = false; };
          DP-1 = {
            enable = true;
            primary = true;
            mode = "3840x2160";
            position = "0x0";
            rate = "60.00";
            # dpi = 182;
          };
          HDMI-0 = {
            enable = true;
            mode = "3840x2160";
            position = "3840x0";
            rate = "60.00";
            # dpi = 182;
          };
        };
      };

      home-single = {
        fingerprint = {
          DP-0 =
          "00ffffffffffff000daee71500000000081b0104952213780228659759548e271e505400000001010101010101010101010101010101b43b804a713834405036680058c11000001acd27804a713834405036680058c11000001a00000000000000000000000000000000000000000002000c47ff0b3c6e1314246e00000000b6";
          DP-1 =
          "00ffffffffffff001e6d095b84dc0700051c0104b53c22789f3035a7554ea3260f50542108007140818081c0a9c0d1c08100010101014dd000a0f0703e803020650c58542100001a286800a0f0703e800890650c58542100001a000000fd00283d878738010a202020202020000000fc004c4720556c7472612048440a2001d80203117144900403012309070783010000023a801871382d40582c450058542100001e565e00a0a0a029503020350058542100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c8";
          HDMI-0 =
          "00ffffffffffff001e6d085b2d3a0000031c0103803c2278ea3035a7554ea3260f50542108007140818081c0a9c0d1c081000101010108e80030f2705a80b0588a0058542100001e04740030f2705a80b0588a0058542100001a000000fd00383d1e873c000a202020202020000000fc004c4720556c7472612048440a2001a7020330714d902220050403020161605d5e5f230907076d030c001000b83c20006001020367d85dc401788003e30f0006023a801871382d40582c450058542100001a565e00a0a0a029503020350058542100001a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa";
        };
        config = {
          DP-0 = { enable = false; };
          DP-2 = { enable = false; };
          DP-3 = { enable = false; };
          DP-4 = { enable = false; };
          DP-1 = {
            enable = true;
            primary = true;
            mode = "3840x2160";
            position = "0x0";
            rate = "60.00";
          };
        };
      };

      mobile = {
        fingerprint = {
          DP-0 =
          "00ffffffffffff000daee71500000000081b0104952213780228659759548e271e505400000001010101010101010101010101010101b43b804a713834405036680058c11000001acd27804a713834405036680058c11000001a00000000000000000000000000000000000000000002000c47ff0b3c6e1314246e00000000b6";
        };
        config = {
          DP-0 = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            position = "0x0";
            rate = "60.01";
          };
        };
      };
    };
  };
}
