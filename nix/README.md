taken from https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050

# Setup

## Install nix

```sh
curl -L https://nixos.org/nix/install | sh
```

Then, reboot shell.


## Emable nix-command and flakes to bootstrap 

```sh
mkdir -p ~/.config/nix
```

```
cat <<EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF
```

## Get the flake.nix in this gist

```sh
cd ~/.config
```

```sh
curl https://raw.githubusercontent.com/i10416/preferences/master/nix/flake.nix -O
```

## Get the configuration.nix and home.nix

```sh
curl https://raw.githubusercontent.com/i10416/preferences/master/nix/configuration.nix -O
```

```sh
curl https://raw.githubusercontent.com/i10416/preferences/master/nix/home.nix -O
```
### Until this is addressed https://github.com/LnL7/nix-darwin/issues/149

```
sudo mv /etc/nix/nix.conf /etc/nix/.nix-darwin.bkp.nix.conf
```

## Build the configuration

```sh
nix build .#darwinConfigurations.j-one.system
```

```sh
./result/sw/bin/darwin-rebuild switch --flake .
```

### on build failure

```sh
printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf  
```

```sh
/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t
```
