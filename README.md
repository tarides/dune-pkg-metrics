# Dune Package Management Metrics

This document outlines the scenarios and metrics used to compare the new Dune package management feature against the traditional setup using opam + Dune. Each scenario aims to highlight differences in setup time, build time, and overall developer experience.

## Comparison Scenarios

1. **Time-to-First-Build**
  - **Description:** This test measures the time taken for a new user to install the necessary tools, create a new project, and complete the first build.
  - **Metric:** Time taken from installing Dune or opam to having the first build completed.
    - Dune: 147 seconds
    - opam: 167 seconds

2. **Time-to-Project-Setup**
  - **Description:** This test measures the time taken for a user who already has a working environment to clone a non-trivial project and build it. It highlights the ability of Dune to cache the compiler and the dependencies to improve user experience once the user has a working setup.
  - **Metric:** Time taken from cloning the Bonsai repository to completing the build.
    - Dune (Cold): 399 seconds
    - Dune (Hot): 63 seconds
    - opam: 269 seconds

3. **Time-to-New-Dependency**
  - **Description:** This test measures the time taken to add a new dependency to an existing project and build it.
  - **Metric:** Time taken from adding a new dependency to having it built.
    - Dune: ??? seconds
    - opam: ??? seconds

4. **Time-to-Upgrade-Dependencies**
  - **Description:** This test measures the time taken to remove the lock file, update all dependencies to their latest versions, and build the project.
  - **Metric:** Time taken from removing the lock file to building the project with the latest versions of all dependencies.
    - Dune: ??? seconds
    - opam: ??? seconds
