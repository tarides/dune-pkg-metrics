#!/bin/bash

set -e

start_time=$(date +%s)

rm -rf my_project | true

git clone https://github.com/janestreet/bonsai.git my_project
cd my_project
git checkout v0.16.0
opam -y switch create . 5.1.1 --deps-only
opam exec -- dune build

end_time=$(date +%s)
time_to_project_setup=$((end_time - start_time))
echo "Time to Project Setup: $time_to_project_setup seconds"
