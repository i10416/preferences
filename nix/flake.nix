{
  description = "i10416's darwin system";

  inputs = {
    # Package sets
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # Environment/system management
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Other sources
    nil.url = "github:oxalica/nil";
    nil.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      darwin,
      nixpkgs,
      home-manager,
      nil,
      ...
    }@inputs:
    let

      inherit (darwin.lib) darwinSystem;
      inherit (inputs.nixpkgs.lib)
        attrValues
        makeOverridable
        optionalAttrs
        singleton
        ;

      # Configuration for `nixpkgs`
      nixpkgsConfig = {
        config = {
          allowUnfree = true;
        };
        overlays =
          attrValues self.overlays
          ++ singleton (
            # Sub in x86 version of packages that don't build on Apple Silicon yet
            final: prev:
            (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
              inherit (final.pkgs-x86)
                ;
            })
          );
      };
    in
    {
      # My `nix-darwin` configs

      darwinConfigurations = {
        i10416s-MBP = darwinSystem {
          system = "aarch64-darwin";
          modules = attrValues self.darwinModules ++ [
            # Main `nix-darwin` config
            ./nix-darwin/configuration.nix
            # `home-manager` module
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              # `home-manager` config
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.yoichiroito = import ./home.nix;
            }
          ];
        };
      };

      # Overlays --------------------------------------------------------------- {{{

      overlays = {
        nil = final: prev: {
          nil = nil.packages.${prev.stdenv.system}.nil;
        };

        # Overlay useful on Macs with Apple Silicon
        apple-silicon =
          final: prev:
          optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            # Add access to x86 packages system is running Apple Silicon
            pkgs-x86 = import inputs.nixpkgs {
              system = "x86_64-darwin";
              inherit (nixpkgsConfig) config;
            };
          };
      };

      # My `nix-darwin` modules that are pending upstream, or patched versions waiting on upstream
      # fixes.
      darwinModules = {

        security-pam =
          # Upstream PR: https://github.com/LnL7/nix-darwin/pull/228
          {
            config,
            lib,
            pkgs,
            ...
          }:

          with lib;

          let
            cfg = config.security.pam;

            # Implementation Notes
            #
            # We don't use `environment.etc` because this would require that the user manually delete
            # `/etc/pam.d/sudo` which seems unwise given that applying the nix-darwin configuration requires
            # sudo. We also can't use `system.patchs` since it only runs once, and so won't patch in the
            # changes again after OS updates (which remove modifications to this file).
            #
            # As such, we resort to line addition/deletion in place using `sed`. We add a comment to the
            # added line that includes the name of the option, to make it easier to identify the line that
            # should be deleted when the option is disabled.
            mkSudoTouchIdAuthScript =
              isEnabled:
              let
                file = "/etc/pam.d/sudo";
                option = "security.pam.services.sudo_local.touchIdAuth";
              in
              ''
                ${
                  if isEnabled then
                    ''
                      # Enable sudo Touch ID authentication, if not already enabled
                      if ! grep 'pam_tid.so' ${file} > /dev/null; then
                        sed -i "" '2i\
                      auth       sufficient     pam_tid.so # nix-darwin: ${option}
                        ' ${file}
                      fi
                    ''
                  else
                    ''
                      # Disable sudo Touch ID authentication, if added by nix-darwin
                      if grep '${option}' ${file} > /dev/null; then
                        sed -i "" '/${option}/d' ${file}
                      fi
                    ''
                }
              '';

          in
          {
            options = {
              /*
                security.pam.enableSudoTouchIdAuth = mkEnableOption ''
                  Enable sudo authentication with Touch ID
                  When enabled, this option adds the following line to /etc/pam.d/sudo:
                      auth       sufficient     pam_tid.so
                  (Note that macOS resets this file when doing a system update. As such, sudo
                  authentication with Touch ID won't work after a system update until the nix-darwin
                  configuration is reapplied.)
                '';
              */
            };

            config = {
              # system.activationScripts.extraActivation.text = ''
              #   # PAM settings
              #   echo >&2 "setting up pam..."
              #   ${mkSudoTouchIdAuthScript cfg.enableSudoTouchIdAuth}
              # '';
            };
          };
      };
    };
}
