#!/bin/bash

# Clean opam
rm -rf ~/.opam _opam dune.lock
brew uninstall opam

start_time=$(date +%s)
brew install opam
opam init -y
opam install dune -y
eval $(opam env --switch=default)
dune --version
end_time=$(date +%s)
delta=$((end_time - start_time))
echo "Time to Setup: $delta seconds"
