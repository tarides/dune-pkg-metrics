#!/bin/bash

set -e

install_dune() {
    ARCH=$(uname -m)
    OS=$(uname -s)

    if [ "$OS" == "Darwin" ]; then
        if [ "$ARCH" == "arm64" ]; then
            curl -L https://dune.ci.dev/binaries/dune-aarch64-apple-darwin.tar.gz | tar -xz
        else
            curl -L https://dune.ci.dev/binaries/dune-x86_64-apple-darwin.tar.gz | tar -xz
        fi
    elif [ "$OS" == "Linux" ] && [ "$ARCH" == "x86_64" ]; then
        curl -L https://dune.ci.dev/binaries/dune-x86_64-unknown-linux-gnu.tar.gz | tar -xz
    else
        echo "Unsupported OS or architecture"
        exit 1
    fi
}

rm -rf ~/.cache/dune my_project dune | true

start_time=$(date +%s)

install_dune
./dune init project my_project
cd my_project
../dune pkg lock
../dune build

end_time=$(date +%s)
time_to_first_build_cold=$((end_time - start_time))
echo "Time to First Build: $time_to_first_build_cold seconds"
