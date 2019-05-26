#! /bin/bash
# Modified version of https://gist.github.com/schickling/2c48da462a7def0a577e

set -e

if [ -z "$1" ]; then
  echo "Usage: docker-machine-import.sh MACHINE_NAME.tar.gz"
  echo ""
  echo "Imports an exported machine from a MACHINE_NAME.tar.gz file"
  #echo "Note: This script requires you to have the same \$MACHINE_STORAGE_PATH/certs available on all host systems"
  exit 0
fi

machine_archive="$1"
machine_name="${machine_archive/.tar.gz/}"
MACHINE_STORAGE_PATH="${MACHINE_STORAGE_PATH:-"$HOME/.docker/machine"}"
machine_path="$MACHINE_STORAGE_PATH/machines/$machine_name"

if [ -d "$machine_path" ]; then
  echo "$machine_name already exists"
  exit 1
fi

rm -rf "$machine_name"
tar -zxvf "$machine_archive" -C "$MACHINE_STORAGE_PATH" > /dev/null
perl -pi -e "s|__MACHINE__STORAGE_PATH__|$MACHINE_STORAGE_PATH|g" $machine_path/config.json

echo "Imported $machine_name to docker-machine ($machine_path)"