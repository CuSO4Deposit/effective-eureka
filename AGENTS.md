# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repo contains a personal infrastructure diagram written in [D2](https://d2lang.com/), a declarative diagramming language. The diagram (`infra.d2`) maps services, data stores, data extraction/loading pipelines, and applications.

Inspired by:
- https://beepb00p.xyz/sad-infra.html
- https://beepb00p.xyz/my-data.html

## Development

The dev environment is managed via Nix flakes (`flake.nix`) with direnv. Entering the directory auto-loads the `d2` CLI.

Build the diagram locally:
```
d2 --sketch --layout=ELK infra.d2 infra.svg
```

Live preview with auto-reload during development:
```
d2 --sketch --layout=ELK --watch infra.d2
```

Build all `.d2` files into `build/` with an HTML index (same as CI):
```
./build.sh
```

## CI/CD

On push to `main`, GitHub Actions (`.github/workflows/build-d2.yml`) builds all D2 diagrams and deploys the SVG output to GitHub Pages via `peaceiris/actions-gh-pages`.

## Diagram Structure

`infra.d2` is organized into these top-level containers:

- **Services WIP** — services being planned/migrated (not yet wired into pipelines)
- **Services** — active external and internal services (bilibili, youtube, arcaea, health tracking, etc.)
- **DEL** (Data Extraction/Loading) — scripts and tools that move data between services and storage (e.g., duplicity, Google Takeout, bili-uploader)
- **Data** — storage nodes organized by host filesystem or cloud service (JuiceFS, phone filesystem, etc.)
- **DAL** (Data Access Layer) — layers that read from data stores (e.g., Y-Offline, duplicity)
- **Applications** — end-user applications (Y-Offline CLI, LogSeq, etc.)

Invisible edges (`style.opacity: 0`) are used within containers to control layout ordering without showing visible connections.

## Diagram Conventions

- `stored_data` shape in Services marks data that lives on local disk (not a remote service)
- `(xN)` suffix on a data node label indicates N copies of that data exist across different locations (both ends should be labeled)
- Dashed edges (`style.stroke-dash: 3`) from Data to Services WIP indicate the same data appearing in both layers (awaiting further extraction)
- `legend.d2` contains the visual legend for all shapes and edge styles
