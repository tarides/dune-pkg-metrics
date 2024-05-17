#!/bin/bash

# Clear cache
rm -rf ~/.cache/dune _build _opam dune.lock
cd my_project

start_time=$(date +%s)

dune pkg lock
dune build

end_time=$(date +%s)
setup_time=$((end_time - start_time))
echo "Setup Time (Cold): $setup_time seconds"

# Cleanup
rm -rf _build dune.lock

start_time=$(date +%s)

dune pkg lock
dune build

end_time=$(date +%s)
setup_time=$((end_time - start_time))
echo "Setup Time (Hot): $setup_time seconds"
