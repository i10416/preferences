{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "yoichiroito";
  # home.homeDirectory = "/Users/yoichiroito";
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
      export PATH=$PATH:/Users/yoichiroito/bin
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
  programs.gh = {
    enable = true;
    settings = { git_protocol = "ssh"; };

  };
  programs.git = {
    enable = true;
    ignores = [
      # vim
      "*~"
      "*.swp"
      # editor related
      ".DS_Store"
      ".vscode"
      # scala
      ".bsp"
      ".metals"
      "target"
      "project/project"
    ];
    userName = "i10416";
    userEmail = "ito.yo16uh90616@gmail.com";
    extraConfig = {
      color = { ui = "auto"; };
      init = { defaultBranch = "main"; };
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
      set expandtab " use spaces instead of tab
      set tabstop=4
      set shiftwidth=4
      set undofile " persist history

      set cursorline " highlight cursor line
      set list " show invisible chars
      set wrap " wrap lines
      set whichwrap=b,s,h,l,<,>,[,] " move to pre/next line when cursor is at the end of line

      set scrolloff=8

      set showmatch  " highlight matching parentheses/ brackets
      set hlsearch " highlight search text
      set incsearch " search incrementally
      set wrapscan " back to first match item after the last one
      colorscheme lunaperche
      set clipboard&
      set clipboard=unnamed,unnamedplus " reset clipboard to default and sync clipboard with OS

      set visualbell " blink cursor on error, instead of beeping

    '';
  };
  home.packages = [
    # base
    pkgs.openssh
    pkgs.git
    pkgs.nixfmt
    pkgs.grpcurl
    pkgs.protobuf

    # haskell 
    pkgs.stack
    pkgs.pandoc
    # scala
    # pkgs.jdk17
    pkgs.jdk11
    pkgs.sbt
    pkgs.coursier
    pkgs.ammonite
    # rust
    pkgs.rustup

    # native
    pkgs.ninja
    pkgs.cmake
    # infra
    pkgs.terraform
    pkgs.google-cloud-sdk
    # signing
    pkgs.gnupg
    # misc
    pkgs.imagemagick
    pkgs.tree
    pkgs.jq
    pkgs.bat
    # gnu compat for osx
    pkgs.coreutils
    pkgs.findutils
    pkgs.gnugrep
    pkgs.gnused
    ## apps
    pkgs.slack
    pkgs.vscode
    pkgs.discord
    pkgs.zoom-us
  ];
  news.display = "silent";
}
