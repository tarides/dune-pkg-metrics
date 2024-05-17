#!/bin/bash

# Clean opam
rm -rf ~/.opam _opam dune.lock
brew uninstall opam

start_time=$(date +%s)
brew install opam
opam init
opam install dune -y
eval $(opam env --switch=default)
end_time=$(date +%s)
delta=$((end_time - start_time))
echo "Opam Install Time (Cold): $delta seconds"
