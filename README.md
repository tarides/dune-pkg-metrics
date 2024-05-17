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

| Use-case | Dune | Opam | Description |
|----------|------|------|-------------|
| Setup environment | ~1s     | ~220s     | Time to setup a new machine and be ready to execute a meaningful command with Dune (dune init, dune build, etc) |
| Setup environment and build new project | ~140s (install: 1s, lock: 61s, build: 79s) | ~400s     | Time to prepare the environment for the first meaningful command, create an empty project, and execute `dune build` for the first time in that environment |
| Build new project in a warm environment | ~12s (lock: 11s, build: 1s) | ~120s     | Time to create a new project, and execute `dune build` in an already setup environment |
| Setup environment and build Bonsai | ~460s (install: 1s, lock: 83s, build: 376s) | ~491s | Time to prepare a fresh environment and build Bonsai v0.16.0 from scratch |
| Build Bonsai in a warm environment | ~314s (lock: 14s, build: 300s) | ~263s | Time to build Bonsai v0.16.0 from scratch in an already set up environment |

**Scripts**:

1. Setup time
   - Dune (./0.install-dune.sh)
   - Opam (./0.install-opam.sh)

2. Setup environment and build new project
   - Dune (./1.install-dune-and-build.sh)
   - Opam (./1.install-opam-and-build.sh)

3. Build new project in a warm environment (requires running #2 first)
   - Dune (./1.install-dune-and-build.sh)
   - Opam (./2.reuse-opam-and-build.sh)

4. Setup environment and build Bonsai
   - Dune (./2.install-dune-and-build-bonsai.sh)
   - Opam (./3.install-opam-and-build-bonsai.sh)

1. Build Bonsai in a warm environment
   - Dune (./2.install-dune-and-build-bonsai.sh)
   - Opam (./4.reuse-opam-and-build-bonsai.sh)
