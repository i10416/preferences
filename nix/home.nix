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
      set encoding=utf8

      set autoindent  " better indent
      set smartindent " even better indent
      set tabstop=4

      set cursorline " highlight cursor line
      set list " show invisible chars
      set wrap " wrap lines
      set whichwrap=b,s,h,l,<,>,[,] " move to pre/next line when cursor is at the end of line

      set scrolloff=8

      set showmatch  " highlight matching parentheses/ brackets
      set hlsearch " highlight search text
      set incsearch " search incrementally
      set wrapscan " back to first match item after the last one

      set clipboard=unnamed,unnamedplus " sync clipboard with OS

      set visualbell " blink cursor on error, instead of beeping

    '';
  };
  home.packages = [
    # base
    pkgs.openssh
    pkgs.git
    pkgs.nixfmt
    # scala
    pkgs.jdk11
    pkgs.sbt
    pkgs.coursier
    pkgs.ammonite

    # native
    pkgs.ninja
    pkgs.cmake
    # infra
    pkgs.terraform
    pkgs.google-cloud-sdk
    # misc
    pkgs.jq
    pkgs.bat

  ];
  news.display = "silent";
}
