# Dune Package Management Metrics

This document outlines the scenarios and metrics used to compare the new Dune package management feature against the traditional setup using opam + Dune. Each scenario aims to highlight differences in setup time, build time, and overall developer experience.

| Use-case | Dune | Opam | Description |
|----------|------|------|-------------|
| Time to Setup | ~1s     | ~220s     | Time to setup a new machine and be ready to execute a meaningful command with Dune (dune init, dune build, etc) |
| Time to First Build (New Project) | ~133s (install: 1s, lock: 53s, build: 79s) | ~330s (setup: 213s, build: 117s) | Time to prepare the environment for the first meaningful command, create an empty project, and execute `dune build` for the first time in that environment |
| Time to Next Build (New Project) | ~12s (lock: 11s, build: 0s) | ~1s (setup: 0s, build: 1s)     | Time to create a new project, and execute `dune build` in an already setup environment |
| Time to First Build (Bonsai) | ~460s (install: 1s, lock: 83s, build: 376s) | ~485 | Time to prepare a fresh environment and build Bonsai v0.16.0 from scratch |
| Time to Next Build (Bonsai) | ~19s (lock: 12s, build: 7s) | ~0s | Time to rebuild Bonsai in a warm-cache environment |

## Use-cases

The measurements we have done follow the usual developer workflows from setting
up an environment to write OCaml, to creating new projects, to cloning and
building existing projects.

### Time to Setup

For starters, we define **time to setup** OCaml with Dune or Opam as the time
it takes to be able to interact with the `dune` binary in any meaningful way:
creating a new project (`dune init`), building an existing one (`dune build`),
or just checking the version (`dune --version). 

We've measured **time to setup with Dune at 1 second**, which is the time
it takes to download and extract the right binary distribution of the Dune
Developer Preview.

This is in contrast to the **time to setup with Opam at 220 seconds**,
which includes installing via `brew`, initializing an opam repository,
installing dune, and enabling the environment to call it.

### Time to First/Next Build

The next interesting developer workflow to measure we call **time to first
build** and includes the creation of a new project, and the first build of it.
We've measured this on a fresh environment that does not have OCaml installed,
and again after setting up the environment.

The **time to first build with Dune sits at ~133s** – around 1s for installing
dune, 53s for creating a lock file for the new project, and 79 seconds to build
it. This build takes slightly over 2 minutes since it must build the OCaml
compiler.

The **time to next build**, or the time it takes to build the project after the
environment was set up the first time, now took only 12 seconds, all dedicated
to regenerating the lock file. This can be avoided too, making this build
effectively instant when no new dependencies are found, and incremental when
new dependencies are added. This is future work.

With a fresh environment and using Opam, the **time to first build** took ~330 seconds –
out of which ~213s are setup time, and the build itself took ~117s. This
includes the cost of creating a new local Opam switch for the project to ensure
it is isolated from the rest.

But **time to next build** with the Opam set up are effectively instant, since
there is no automatic relocking in place. This means that adding new
dependencies remains a manual step.

### Bonsai

We also include measurements for **time to first build** and **time to next
build** for the Bonsai project.

With Dune, the **time to first build** took ~460s, of which locking took ~83s,
building ~376s, and installing dune took only 1s.

The **time to next build** sits at 19 seconds with relocking, and just 7
seconds if running `dune build` directly.

With Opam, the **time to first build** took 485s, of which building the project
took 271. The **time to next build** is effecitvely instant after that.
