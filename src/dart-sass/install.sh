#!/bin/bash
set -e

# Determine architecture
case "$(uname -m)" in
    aarch64|arm64) ARCH=arm64 ;;
    riscv64)       ARCH=riscv64 ;;
    *)             ARCH=x64 ;;
esac

VERSION=${VERSION:-"latest"}

# Determine latest version
if [[ ${VERSION} == "latest" ]]; then
    VERSION=$(curl -s https://api.github.com/repos/sass/dart-sass/releases/latest | grep tag_name | cut -d '"' -f 4)
fi

echo "Installing the ${ARCH} ${VERSION} version of dart-sass"


FILENAME=dart-sass-${VERSION}-linux-${ARCH}.tar.gz

curl -LJO "https://github.com/sass/dart-sass/releases/download/${VERSION}/${FILENAME}"

tar -xf "${FILENAME}"

cp -r dart-sass/* /usr/local/bin

rm -r dart-sass*
