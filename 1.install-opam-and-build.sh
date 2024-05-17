#!/bin/bash

# Clean up
rm -rf new_empty_project

start_time=$(date +%s)
./0.install-opam.sh
eval $(opam env --switch=default)

dune init proj new_empty_project
pushd new_empty_project
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
