{ pkgs, ... }:

with pkgs; [
  # General packages for development and system management
  alacritty
  neofetch
  wget

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg

  # Text and terminal utilities
  htop
]
