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
