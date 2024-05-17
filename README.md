# Dune Package Management Metrics

This document outlines the scenarios and metrics used to compare the new Dune package management feature against the traditional setup using opam + Dune. Each scenario aims to highlight differences in setup time, build time, and overall developer experience.

## Comparison Scenarios

1. **Basic Project Setup**
   - **Description:** Setting up a new OCaml project without dependencies. Shows difference between opam and Dune solver performance, and highlights benefits of caching the compiler with Dune toolchain.
   - **Metric:** Time taken to build a basic project in a project-based setup.
    - Dune: Setup Time (Cold): 126 seconds
    - Dune: Setup Time (Hot): 10 seconds
    - Opam: Setup Time (Cold): 108 seconds
    - Opam: Setup Time (Hot): N/A - not applicable

2. **Multi-Dependency Project**
   - **Description:** Building a project with multiple dependencies. Shows performance gains in caching dependencies in Dune's global cache.
   - **Metric:** Time taken to resolve, fetch, and install all dependencies, exluding the compiler.
    - Dune: Setup Time (Cold): 36 seconds
    - Dune: Setup Time (Hot): 13 seconds
    - Opam: Setup Time (Cold): 59 seconds
    - Opam: Setup Time (Hot): N/A - not applicable

## More measurements

> **Note for replication:** Please note that these must be ran in order.

1. **First Meaningful Command** / **Setup time**
   - **Description:** The time it takes to setup a new machine and be ready to
     execute a meaningful command with Dune (dune init, dune build, etc)
   - **Measurements:**:
     - Dune (./0.install-dune.sh): ~1 second
     - Opam (./install-opam.sh): ~220 seconds 

1. **Time to First Build** for New Projects in a Fresh environement
   - **Description:** The time it takes to prepare the environment for the
     first meaningful command, create an empty project, and execute `dune
     build` for the first time in that environment.
   - **Metric:**:
     - Dune (./1.install-dune-and-build.sh): ~140 seconds (install: 1s, lock: 61s, build: 79s)
     - Opam (./1.install-opam-and-build.sh): ~400 seconds

1. **Time to Next First Build** for New Projects in a Warm environment
   - **Description:** The time it takes to create a new project, and execute
     `dune build` in an already setup environment.
   - **Metric:**:
     - Dune (./1.install-dune-and-build.sh): ~12 seconds (lock: 11s, build: 1s)
     - Opam (./2.reuse-opam-and-build.sh): ~120 seconds

1. **Time to First Build** for Bonsai in a Fresh Environment
   - **Description:** The time it takes to prepare a fresh environment and build
     the Bonsai (v0.16.0) project.
   - **Metric:**:
     - Dune (./2.install-dune-and-build-bonsai.sh): ~460 seconds (install: 1s, lock: 83s, build: 376s)
     - Opam (./3.install-opam-and-build-bonsai.sh): <measuring>

1. **Time to First Build** for Bonsai in a Warm Environment
   - **Description:** The time it takes to build the Bonsai (v0.16.0) project
     in an already setup environment.
   - **Metric:**:
     - Dune (./2.install-dune-and-build-bonsai.sh): ~314 seconds (lock: 14s, build: 300s)
     - Opam (./4.reuse-opam-and-build-bonsai.sh): <measuring>
