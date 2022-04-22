{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "i10416";
  home.homeDirectory = "/Users/i10416";
  home.language.base = "en_US.UTF-8";
  fonts.fontconfig.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableSyntaxHighlighting = true;
    sessionVariables = { EDITOR = "vim"; };
    envExtra = ''
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        . ~/.nix-profile/etc/profile.d/nix.sh
      fi
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };

  };
  programs.git = {
    enable = true;
    ignores = [
      "*~" 
      "*.swp" 
      ".DS_Store" 
    ];
    userName = "i10416";
    userEmail = "ito.yo16uh90616@gmail.com";
    extraConfig = {
      color = {
        ui = "auto";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
  programs.vim = {
    enable = true;
    settings = {
      ignorecase = true;
      number = true;
    };
    extraConfig = ''
      set autoindent
      set smartindent
      set tabstop=4
    '';
  };
  home.packages = [
    pkgs.git
    pkgs.nixfmt
    pkgs.jdk11
    pkgs.sbt
    pkgs.openssh
    pkgs.ninja
    pkgs.cmake
    pkgs.jdk11
    pkgs.jq
  ];
}
