# CHANGELOG for Noesis v0.2.0

## Overview
This version represents a major restructuring of the Noesis project, separating it into core and extensions components with different licenses.

## Major Changes
- Separated the project into two distinct components:
  - `noesis-core`: Contains the essential consciousness simulation with no external dependencies
  - `noesis-extensions`: Contains quantum computing modules and tools with MIT license

## License Changes
- Core functionality remains under the original Noesis License
- Extensions now use the MIT License for broader adoption and integration

## Build System
- Created separate Makefiles for each component
- Added build scripts for unified building
- Created a linking system between core and extensions
- Added Docker support for the new structure

## Documentation
- Updated README files for each component
- Added migration guide for users of the original structure
- Created documentation for the new build and run process

## Scripts and Tools
- Added `build_all.fish` for building both components
- Added `run_core.fish` and `run_extensions.fish` for running each component
- Updated `run_noesis.fish` to support both old and new structures
- Added `migrate.fish` to help users migrate to the new structure

## Directory Structure
- Reorganized files into logical components
- Established clear boundaries between core and extension code
- Created separate test directories for each component

## Date
May 12, 2025
