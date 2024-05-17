#!/bin/bash

cd my_project
rm -rf _build _opam dune.lock

opam -y switch create . 5.1.1 --no-install

start_time=$(date +%s)
opam install -y yojson lwt cohttp
opam exec -- dune build

end_time=$(date +%s)
setup_time=$((end_time - start_time))
echo "Setup Time: $setup_time seconds"
