{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    git
    neovim
    kitty
    hyprland 
  ];

  programs.git = {
    enable = true;
    userName = "Dung Vu";
  };

  programs.zsh.enable = true;
  programs.bat.enable = true;
}

