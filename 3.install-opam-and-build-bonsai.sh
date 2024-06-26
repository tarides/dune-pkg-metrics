#!/bin/bash

# Clean up
rm -rf bonsai
rm -rf ~/.opam _opam dune.lock
brew uninstall opam
git clone https://github.com/janestreet/bonsai --sparse -b v0.16.0

start_time=$(date +%s)
brew install opam
opam init -y
opam install dune -y
eval $(opam env --switch=default)
end_time=$(date +%s)
delta=$((end_time - start_time))
echo "Opam Install Time (Cold): $delta seconds"

pushd bonsai
  start_build_time=$(date +%s)
  opam -y switch create . 5.1.1 --deps-only
  dune build
  end_build_time=$(date +%s)
popd

build_time=$((end_build_time - start_build_time))
echo "Build Time (Cold): $build_time seconds"

end_time=$(date +%s)
time_to_first_build=$((end_time - start_time))
echo "Time to First Build: $time_to_first_build seconds"
