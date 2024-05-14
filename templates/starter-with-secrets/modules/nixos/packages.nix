{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [

  rofi
  rofi-calc
  # Screenshot and recording tools
  flameshot

  tree
  xclip # For the org-download package in Emacs

  # Other utilities
  # brave
]
