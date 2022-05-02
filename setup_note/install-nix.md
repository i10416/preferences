## Install Nix package manager

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

## Fix Crash on OSX Update

Nix が OSX のアップデートで見つからない場合、次のコードを　/etc/zshrc に追記することで修正できる場合がある. これは　　OSX がアップデート時に/etc/zshrc を上書きすることがあるため起きるエラー.


Add the following lines in /etc/zshrc


```sh
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
```

https://github.com/NixOS/nix/issues/3616#issuecomment-903869569

## Links

https://nixos.org/download.html
