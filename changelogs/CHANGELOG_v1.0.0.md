# CHANGELOG for Noesis Extend v1.0.0

## Overview
This is the first release of Noesis Extend as a separate repository, extracted from the original Noesis project.

## Major Changes
- Moved all extensions to a dedicated repository
- Updated build system to work with separate repositories
- Updated scripts to find the Noesis core through environment variables

## New Features
- Added `link_libraries.fish` updated to work across repositories
- Added repository-specific installation script
- Added `run.fish` for simpler execution

## Build System
- Updated Makefile to reference external Noesis core repository
- Executable name changed to `noesis_extend`

## Documentation
- Updated README.md to explain the dependency on Noesis core
- Added installation instructions

## Date
May 12, 2025
