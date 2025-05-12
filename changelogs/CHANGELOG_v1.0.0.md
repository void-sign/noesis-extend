# CHANGELOG for Noesis Hub v1.0.0

## Overview
This is the first release of Noesis Hub as a separate and independent connector hub for Noesis Core, extracted from the original Noesis project's `noesis-extensions` directory. This change was made to provide a more permissive MIT license, clearer separation of concerns, and greater independence for platform integration development.

## Major Changes
- Established Noesis Hub as an independent connector system with its own repository
- Moved all extensions from `noesis-extensions` directory to this dedicated repository
- Created clean API boundary (noesis_api.h) for communication with Noesis Core
- Updated build system to work with separate repositories
- Updated scripts to find the Noesis Core through environment variables
- Changed license to MIT License (from the original Noesis License)
- Added improved cross-repository dependency management
- Implemented dynamic loading of Noesis Core library
- Moved all quantum-related functionality back to Noesis Core repository

## New Features
- Added `link_libraries.sh` for flexible cross-repository integration
- Added repository-specific installation script with multiple installation options
- Added `run.sh` for simpler execution
- Implemented platform-independent dynamic library loading mechanism
- Created standalone mode option for independent operation
- Added both `.sh` (default) and `.fish` (alternative) script options for better shell compatibility
  - Fish shell support for all core scripts (`install.fish`, `run.fish`, etc.)
  - Dedicated `fish_scripts` directory for Fish shell variants
- Added environment setup script (`launch_noesis_env.sh`/`.fish`)

## Build System
- Updated Makefile to reference external Noesis Core repository
- Executable name changed to `noesis_extend`
- Added support for both linked and dynamically loaded operation modes
- Added dependency installation script (`install_dependency.sh`/`.fish`)

## Documentation
- Updated README.md to explain the relationship with Noesis Core
- Added installation instructions with multiple setup options
- Added clear explanation of the repository split and licensing differences
- Documented the independent nature of Noesis Hub as a separate connector system
- Added ECOSYSTEM.md documenting the relationship between Noesis project components
- Added CONTRIBUTING.md with guidelines for contributors
- Added comprehensive docheader comments to quantum source files

## API Changes
- Created clean API boundary through noesis_api.h
- Implemented standardized function pointer types for core functions
- Added platform-independent dynamic library handling

## Testing
- Added test-specific make target (`make test`)

## Date
May 12, 2025
