#!/bin/bash
set -o pipefail -eu

SPACKPATH=$(realpath $(pwd)/../spack/etc/spack)
if [ -d ${SPACKPATH} ]; then
    echo "Linking configuration files to the spack tree"
else
    echo "Spack folder not found!"
fi

configs=($(ls *.yaml))

for cfg in "${configs[@]}"; do
    printf "  $cfg: "
    if [ -h ${SPACKPATH}/${cfg} ]; then
        printf "exists, not linking.\n"
    else
        ln -s  $(pwd)/${cfg} ${SPACKPATH} && printf "linked.\n"
    fi
done
