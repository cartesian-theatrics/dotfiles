#!/usr/bin/env bash
DOTFILES="$(cd $(dirname "${BASH_SOURCE:-${(%):-%x}}") && pwd -P)"
PREFIX="${PREFIX:-/mnt}"
NIXOSPREFIX="${PREFIX}/etc/nixos"
HOST=${1:-${HOST:-omen}}

set -e
if [[ ! -f "$DOTFILES/configuration.$HOST.nix" ]]; then
  >&2 echo "No configuration exists for host '$HOST'"
  exit 1
elif [[ ! -f "$NIXOSPREFIX/hardware-configuration.nix" ]]; then
  >&2 echo "No hardware-configuration.nix file exists in $NIXOSPREFIX"
  >&2 echo "Did you forget to set up your partitions?"
  exit 2
fi

mkdir -p "$NIXOSPREFIX"
cat << EOF > "$NIXOSPREFIX/configuration.nix"
{ config, ... }:
{
  imports = [
    ../dotfiles/configuration.$HOST.nix
    ./hardware-configuration.nix
  ]
}
EOF

nix-channel --add https://nixos.org/channels/nixos-19.09 nixos
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
nix-channel --update

nixos-generate-config --root "$PREFIX"
nixos-install --root "$PREFIX" -I "config=$DOTFILES"
