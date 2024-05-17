#!/bin/bash

set -e

export OPAMROOT=$(pwd)/opamroot

# Function to install opam
install_opam() {
    bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
}

# Clean any previous cache
rm -rf my_project dune opamroot | true

start_time=$(date +%s)

install_opam
opam init -y
mkdir my_project
cd my_project
opam -y switch create . 5.1.0 --no-install
opam install -y dune
opam exec -- dune init project my_project .
opam exec -- dune build

end_time=$(date +%s)
time_to_first_build_cold=$((end_time - start_time))
echo "Time to First Build: $time_to_first_build_cold seconds"
