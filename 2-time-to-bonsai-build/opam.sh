#!/bin/bash

# Clean up
rm -rf bonsai
git clone https://github.com/janestreet/bonsai --sparse -b v0.16.0

if [[ $1 = "cold" ]]; then
  echo "Cold build, removing ~/.opam and _opam..."
  rm -rf ~/.opam _opam
  brew uninstall opam
fi

start_time=$(date +%s)

if [[ $1 = "cold" ]]; then
  brew install opam
  opam init -y
  opam install dune -y
fi

eval $(opam env --switch=default)

pushd bonsai
  start_build_time=$(date +%s)
  if [[ $1 = "cold" ]]; then
    opam -y switch create . 5.1.1 --deps-only
  fi
  dune build
  end_build_time=$(date +%s)
popd

build_time=$((end_build_time - start_build_time))
echo "Build Time (Cold): $build_time seconds"

end_time=$(date +%s)
time_to_first_build=$((end_time - start_time))
echo "Time to First Build: $time_to_first_build seconds"
