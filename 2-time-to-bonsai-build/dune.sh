#!/bin/bash

# Clean up
rm -rf bonsai
git clone https://github.com/janestreet/bonsai --sparse -b v0.16.0

if [[ $1 = "cold" ]]; then
  echo "Cold build, removing global toolchains and local cache..."
  rm -rf ~/.cache/dune _build
  rm -rf dune*.tar.gz dune dune.lock
fi

start_time=$(date +%s)
wget https://dune.ci.dev/binaries/dune-aarch64-apple-darwin.tar.gz
tar xzf dune-aarch64-apple-darwin.tar.gz
export PATH=$(pwd):$PATH
export DUNE_CACHE=enabled

pushd bonsai
  start_lock_time=$(date +%s)
  dune pkg lock
  end_lock_time=$(date +%s)

  start_build_time=$(date +%s)
  dune build
  end_build_time=$(date +%s)

  second_build_time=$(date +%s)
  dune build
  end_second_build_time=$(date +%s)
popd

lock_time=$((end_lock_time - start_lock_time))
echo "Lock Time (Cold): $lock_time seconds"

build_time=$((end_build_time - start_build_time))
echo "Build Time (Cold): $build_time seconds"

end_time=$(date +%s)
time_to_first_build=$((end_time - start_time))
echo "Time to First Build: $time_to_first_build seconds"

time_to_second_build=$((end_second_build_time - second_build_time))
echo "Time to Second Build: $time_to_second_build seconds"

