{ pkgs, lib, ... }: {
  # Nix configuration ------------------------------------------------------------------------------

  nix.settings.substituters = [ "https://cache.nixos.org/" ];
  nix.settings.trusted-public-keys =
    [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  nix.settings.trusted-users = [ "@admin" ];
  nix.configureBuildUsers = true;
  # users.nix.configureBuildUsers = true;
  users.users.yoichiroito.home = "/Users/yoichiroito";
  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [ 
    vscode
    jetbrains.idea-community
  ];

  # Fonts
  # fonts.packages.enable = true;
  fonts.packages = with pkgs; [
    recursive
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      NSGlobalDomain = {
        AppleShowScrollBars = "Always";
        AppleShowAllFiles = true;
        NSAutomaticWindowAnimationsEnabled = false;
        NSUseAnimatedFocusRing = false;
        # NSWindowResizeTime = 0.01;
      };
      dock = {
        tilesize = 48;
        autohide = false;
        launchanim = false;
        orientation = "bottom";
        # autohide-delay = 0.0;
      };
    };
  };
  networking = {
    dns = [ "8.8.8.8" "127.0.0.1" ];
    search = [ "local" ];
    knownNetworkServices = [ "Ethernet" "Wi-Fi" ];
  };

  # Add ability to used TouchID for sudo authentication
  # security.pam.enableSudoTouchIdAuth = true;

}
