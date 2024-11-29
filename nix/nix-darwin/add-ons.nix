{ pkgs, ... }:
{
  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [
    vscode
    jetbrains.idea-community
  ];
  # Fonts
  fonts.packages = with pkgs; [
    recursive
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
