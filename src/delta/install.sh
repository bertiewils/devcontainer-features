#!/bin/bash
set -e

VERSION=${VERSION:-"latest"}
ARCH=$(dpkg --print-architecture)

# Determine latest version
if [[ ${VERSION} == "latest" ]]; then
    VERSION=$(curl -s https://api.github.com/repos/dandavison/delta/releases/latest | grep tag_name | cut -d '"' -f 4)
fi

echo "Installing the ${ARCH} ${VERSION} version of delta"


FILENAME=git-delta_${VERSION}_${ARCH}.deb

curl -LJO "https://github.com/dandavison/delta/releases/download/${VERSION}/${FILENAME}"

dpkg -i "${FILENAME}"

rm "${FILENAME}"
