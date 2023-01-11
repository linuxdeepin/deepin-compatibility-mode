#!/bin/bash

set -x

function handle_usr_desktop() {
	desktops=$(find "$1"/applications -name "*.desktop")

	for desktop in "${desktops[@]}"; do
		cp "$desktop" "$2"
		sed "s/Exec=/Exec=loader --deb-id $(basename "$file") -- /g" -i "$2"/"$(basename "$desktop")"
	done
}

file=$1
file_real_path="$(readlink -f "$file")"

rm -rf .tmp
mkdir .tmp

pushd .tmp || return

dpkg-deb -R "$file_real_path" tmp

filename=$(basename "$file")
array=(${filename//_/ })
working_dir=working_dir/opt/apps/${array[0]}/entries/
mkdir -p "$working_dir"
mkdir -p "$working_dir"/applications/

if [[ -d "tmp/usr" ]]; then
	handle_usr_desktop tmp/usr/share/ "$working_dir"/applications/
fi

if [[ -d "tmp/opt" ]]; then
	apps=$(ls tmp/opt/apps)
	for p in "${apps[@]}"; do
		handle_usr_desktop tmp/opt/apps/"$p"/entries "$working_dir"/applications/
		cp -a tmp/opt/apps/"$p"/entries/icons "$working_dir"/ # check exists
		cp -a tmp/opt/apps/"$p"/info "$working_dir"
	done
fi

mkdir -p "$working_dir"/files
cp "$file_real_path" "$working_dir"/files/

sed /Depends:/d -i tmp/DEBIAN/control
sed /Recommends:/d -i tmp/DEBIAN/control
sed /Conflicts:/d -i tmp/DEBIAN/control
sed /Replaces:/d -i tmp/DEBIAN/control
sed /Provides:/d -i tmp/DEBIAN/control

rm tmp/DEBIAN/md5sums

mkdir working_dir/DEBIAN
cp -a tmp/DEBIAN/control working_dir/DEBIAN

dpkg-deb -b working_dir .

popd || return
