#!/bin/bash

# Clean up
rm -rf bonsai
git clone https://github.com/janestreet/bonsai --sparse -b v0.16.0

start_time=$(date +%s)
./0.install-dune.sh

pushd bonsai
  start_lock_time=$(date +%s)
  dune pkg lock
  end_lock_time=$(date +%s)

  start_build_time=$(date +%s)
  dune build
  end_build_time=$(date +%s)
popd

lock_time=$((end_lock_time - start_lock_time))
echo "Lock Time (Cold): $lock_time seconds"

build_time=$((end_build_time - start_build_time))
echo "Build Time (Cold): $build_time seconds"

end_time=$(date +%s)
time_to_first_build=$((end_time - start_time))
echo "Time to First Build: $time_to_first_build seconds"
