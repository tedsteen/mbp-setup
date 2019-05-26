#! /bin/bash
# Modified version of https://gist.github.com/schickling/2c48da462a7def0a577e

if [ -z "$1" ]; then
  echo "Usage: machine-export.sh MACHINE_NAME"
  echo ""
  echo "Exports the specified docker-machine to a MACHINE_NAME.zip file"
  echo "Note: This script requires you to have the same \$MACHINE_STORAGE_PATH/certs available on all host systems"
  exit 0
fi

machine_name=$1

docker-machine status $machine_name 2>&1 > /dev/null
if [ $? -ne 0 ]; then
  echo "No such machine found"
  exit 1
fi

set -e

MACHINE_STORAGE_PATH="${MACHINE_STORAGE_PATH:-"$HOME/.docker/machine"}"
machine_path="$MACHINE_STORAGE_PATH/machines/$machine_name"
cert_path="$MACHINE_STORAGE_PATH/certs"
tmp_path="/tmp/machine-export-$(date +%s%3)"

# copy to /tmp and strip out $MACHINE_STORAGE_PATH
mkdir -p $tmp_path
mkdir $tmp_path/machines
cp -r "$machine_path" "$tmp_path/machines/$machine_name"
cp -r "$cert_path" "$tmp_path"
perl -pi -e "s|$MACHINE_STORAGE_PATH|__MACHINE__STORAGE_PATH__|g" $tmp_path/machines/$machine_name/config.json

# create zip
rm -f "$machine_name.tar.gz"
tar -zcvf "$machine_name.tar.gz" -C "$tmp_path" . > /dev/null

echo "Exported machine to $machine_name.tar.gz"

# cleanup
rm -rf $tmp_path