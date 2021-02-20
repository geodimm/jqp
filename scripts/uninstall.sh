#! /usr/bin/env bash

set -e

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
JQ_MODULES_DIR="${HOME}/.jq"
JQP_BIN_DIR="${HOME}/bin/"
JQP_MODULE_DIR="${JQ_MODULES_DIR}/jqp"
JQP_CONFIG_DIR="${XDG_CONFIG_HOME}/jqp"

echo "Uninstalling binary..."
rm -f "${JQP_BIN_DIR}/jqp"

echo "Uninstalling jq module..."
rm -rf "${JQP_MODULE_DIR}"

echo "Removing configuration directory..."
rm -rf "${JQP_CONFIG_DIR}"

echo "Uninstallation complete!"
