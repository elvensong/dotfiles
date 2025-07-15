{ config, pkgs, ... }:

{
  imports = [ ../home.nix ]; # shared config

  home.packages = with pkgs; [
  ];

  programs.git.userEmail = "dung.vu.eve@gmail.com";
}

