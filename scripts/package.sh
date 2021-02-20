#! /usr/bin/env bash

set -e

ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"

TAG="${TAG:-$(git describe --tags --abbrev=0)}"

mkdir -p "${ROOT}/build"

ASSETS=(
    jqp
    jqp.jq
)

tar -C "${ROOT}" -czf "build/jqp-${TAG}.tar.gz" "${ASSETS[@]}"
