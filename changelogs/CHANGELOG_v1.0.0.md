# CHANGELOG for Noesis-Extend v1.0.0

## Overview
This is the first release of Noesis-Extend as a separate and independent extension system for Noesis Core, extracted from the original Noesis project's `noesis-extensions` directory. This change was made to provide a more permissive MIT license, clearer separation of concerns, and greater independence for extension development.

## Major Changes
- Established Noesis-Extend as an independent extension system with its own repository
- Moved all extensions from `noesis-extensions` directory to this dedicated repository
- Created clean API boundary (noesis_api.h) for communication with Noesis Core
- Updated build system to work with separate repositories
- Updated scripts to find the Noesis Core through environment variables
- Changed license to MIT License (from the original Noesis License)
- Added improved cross-repository dependency management
- Implemented dynamic loading of Noesis Core library

## New Features
- Added `link_libraries.sh` for flexible cross-repository integration
- Added repository-specific installation script with multiple installation options
- Added `run.sh` for simpler execution
- Implemented platform-independent dynamic library loading mechanism
- Created standalone mode option for independent operation
- Added quantum computing backend interface system
- Added both `.sh` (default) and `.fish` (alternative) script options for better shell compatibility

## Build System
- Updated Makefile to reference external Noesis Core repository
- Executable name changed to `noesis_extend`
- Added support for both linked and dynamically loaded operation modes

## Documentation
- Updated README.md to explain the relationship with Noesis Core
- Added installation instructions with multiple setup options
- Added clear explanation of the repository split and licensing differences
- Documented the independent nature of Noesis-Extend as a separate extension system

## API Changes
- Created clean API boundary through noesis_api.h
- Implemented standardized function pointer types for core functions
- Added platform-independent dynamic library handling

## Date
May 12, 2025
