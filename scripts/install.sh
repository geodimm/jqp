#! /usr/bin/env bash

set -e

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
JQ_MODULES_DIR="${HOME}/.jq"
JQP_BIN_DIR="${HOME}/bin/"
JQP_MODULE_DIR="${JQ_MODULES_DIR}/jqp"

version="latest"
path="latest"
if [ -n "${JQP_VERSION}" ]; then
	version="${JQP_VERSION}"
	path="tags/$version"
fi
echo "Finding $version release..."
asset=$(curl --silent "https://api.github.com/repos/geodimm/jqp/releases/$path" | jq -r '.assets // [] | .[] | select(.name | startswith("jqp")) | .url')
if [[ -z $asset ]]; then
	echo "Cannot find the latest release. Please try again later."
	exit 0
fi
echo "Downloading $version release..."
mkdir -p /tmp/jqp
curl --silent --location -H "Accept: application/octet-stream" "${asset}" | tar xz -C "/tmp/jqp"

echo "Installing binary..."
mkdir -p "${JQP_BIN_DIR}"
chmod +x /tmp/jqp/jqp
mv /tmp/jqp/jqp "${JQP_BIN_DIR}/jqp"

echo "Installing jq module..."
mkdir -p "${JQP_MODULE_DIR}"
mv /tmp/jqp/jqp.jq "${JQP_MODULE_DIR}"

rm -rf /tmp/jqp

command -v jqp &>/dev/null || (echo "Please add ${JQP_BIN_DIR} to your PATH to complete installation!" && exit 0)
echo "Installation complete!"
