{ config, pkgs, ... }:

{
  imports = [ ../home.nix ]; # shared config

  home.packages = with pkgs; [
  ];

  programs.git.userEmail = "dung.vu@aurionpro.com";
}

