{ config, inputs, pkgs, ... }:

let user = "zaiheshi"; in
{
  imports = [
    ../../modules/nixos/disk-config.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    # Uncomment for AMD GPU
    # initrd.kernelModules = [ "amdgpu" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "uinput" ];
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    hostName = "nixos"; # Define your hostname.
    useDHCP = false;
    interfaces."enp0s3".useDHCP = true;
  };


  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays =
      # Apply each overlay found in the /overlays directory
      let path = ../../overlays; in with builtins;
      map (n: import (path + ("/" + n)))
          (filter (n: match ".*\\.nix" n != null ||
                      pathExists (path + ("/" + n + "/default.nix")))
                  (attrNames (readDir path)));
  };

  # Manages keys and such
  programs = {
    gnupg.agent.enable = true;

    # Needed for anything GTK related
    dconf.enable = true;

    # My shell
    zsh.enable = true;
  };

  services = {
    # xserver = {
      # enable = true;
      # desktopManager.plasma5.enable = true;
      # displayManager.sddm.enable = true;

      # Uncomment these for AMD or Nvidia GPU
      # videoDrivers = [ "amdgpu" ];
      # videoDrivers = [ "nvidia" ];

      # Uncomment this for Nvidia GPU
      # This helps fix tearing of windows for Nvidia cards
      # services.xserver.screenSection = ''
      #   Option       "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      #   Option       "AllowIndirectGLXProtocol" "off"
      #   Option       "TripleBuffer" "on"
      # '';

      # LightDM Display Manager

      # Turn Caps Lock into Ctrl
      # layout = "us";

      # Better support for general peripherals
      # libinput.enable = true;
    # };

    # Let's be able to SSH into this machine
    openssh.enable = true;

  };

  # Enable sound
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Video support
  # hardware = {
    # opengl.enable = true;
    # nvidia.modesetting.enable = true;

    # Enable Xbox support
    # xone.enable = true;

    # Crypto wallet support
    # ledger.enable = true;
  # };


  # It's me, it's you, it's everyone
  users.users = {
    ${user} = {
      isNormalUser = true;
      extraGroups = [
        "wheel" # Enable ‘sudo’ for the user.
      ];
      shell = pkgs.zsh;
    };

  };

  # Don't require password for users in `wheel` group for these commands
  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [
       {
         command = "${pkgs.systemd}/bin/reboot";
         options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };

  # fonts.packages = with pkgs; [
  # ];

  environment.systemPackages = with pkgs; [
    git
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.substituters = lib.mkForce ["https://mirrors.ustc.edu.cn/nix-channels/store" ];
  system.stateVersion = "23.11"; # Don't change this
}
