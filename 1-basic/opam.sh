#!/bin/bash

cd my_project
rm -rf _build _opam dune.lock

start_time=$(date +%s)

opam -y switch create . 5.1.1 --deps-only
opam exec -- dune build

end_time=$(date +%s)
setup_time=$((end_time - start_time))
echo "Setup Time: $setup_time seconds"
