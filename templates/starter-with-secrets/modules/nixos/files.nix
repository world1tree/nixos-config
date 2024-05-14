{ user, ... }:

let
  home           = builtins.getEnv "HOME";
  xdg_configHome = "${home}/.config";
  xdg_dataHome   = "${home}/.local/share";
  xdg_stateHome  = "${home}/.local/state"; in
{

  "${xdg_configHome}/polybar/bin/check-nixos-updates.sh" = {
    executable = true;
    text = ''
      #!/bin/sh

      /run/current-system/sw/bin/git -C ~/.local/share/src/nixpkgs fetch upstream master
      UPDATES=$(/run/current-system/sw/bin/git -C ~/.local/share/src/nixpkgs rev-list origin/master..upstream/master --count 2>/dev/null);
      /run/current-system/sw/bin/echo " $UPDATES"; # Extra space for presentation with icon
      /run/current-system/sw/bin/sleep 1800;
    '';
  };

  "${xdg_configHome}/polybar/bin/search-nixos-updates.sh" = {
    executable = true;
    text = ''
      #!/bin/sh

      /etc/profiles/per-user/${user}/bin/google-chrome-stable --new-window "https://search.nixos.org/packages"
    '';
  };

  "${xdg_configHome}/rofi/colors.rasi".text = builtins.readFile ./config/rofi/colors.rasi;
  "${xdg_configHome}/rofi/confirm.rasi".text = builtins.readFile ./config/rofi/confirm.rasi;
  "${xdg_configHome}/rofi/launcher.rasi".text = builtins.readFile ./config/rofi/launcher.rasi;
  "${xdg_configHome}/rofi/message.rasi".text = builtins.readFile ./config/rofi/message.rasi;
  "${xdg_configHome}/rofi/networkmenu.rasi".text = builtins.readFile ./config/rofi/networkmenu.rasi;
  "${xdg_configHome}/rofi/powermenu.rasi".text = builtins.readFile ./config/rofi/powermenu.rasi;
  "${xdg_configHome}/rofi/styles.rasi".text = builtins.readFile ./config/rofi/styles.rasi;

  "${xdg_configHome}/rofi/bin/launcher.sh" = {
    executable = true;
    text = ''
      #!/bin/sh

      rofi -no-config -no-lazy-grab -show drun -modi drun -theme ${xdg_configHome}/rofi/launcher.rasi
    '';
  };

}
