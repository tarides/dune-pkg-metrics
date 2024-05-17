#!/bin/bash

# Clean up
rm -rf dune*.tar.gz dune

start_time=$(date +%s)
wget https://dune.ci.dev/binaries/dune-aarch64-apple-darwin.tar.gz
tar xzf dune-aarch64-apple-darwin.tar.gz
export PATH=$(pwd):$PATH
dune --version
end_time=$(date +%s)
delta=$((end_time - start_time))
echo "Time to Setup: $delta seconds"
