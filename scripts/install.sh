#! /usr/bin/env bash

set -e

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
JQ_MODULES_DIR="${HOME}/.jq"
JQP_BIN_DIR="${HOME}/bin/"
JQP_MODULE_DIR="${JQ_MODULES_DIR}/jqp"

echo "Downloading..."
mkdir -p /tmp/jqp
curl -s -L "https://api.github.com/repos/georgijd/jqp/tarball/main" | tar xz --strip=1 -C "/tmp/jqp"

echo "Installing binary..."
mkdir -p "${JQP_BIN_DIR}"
chmod +x /tmp/jqp/jqp
mv /tmp/jqp/jqp "${JQP_BIN_DIR}/jqp"

echo "Installing jq module..."
mkdir -p "${JQP_MODULE_DIR}"
mv /tmp/jqp/jqp.jq "${JQP_MODULE_DIR}"

rm -rf /tmp/jqp

which jqp &> /dev/null || (echo "Please add ${BIN_INSTALL_DIR} to your PATH to complete installation!" && exit 1)
echo "Installation complete!"
