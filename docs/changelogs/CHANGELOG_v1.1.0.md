# Changelog for Noesis Hub v1.1.0

## What's New

### API Integration

- Added a Fish-based API for communication with noe-core repositories
- Implemented RESTful API endpoints for processing `.noe` files
- Added API server functionality using socat
- Created comprehensive API documentation

### Repository Structure Updates

- Restructured the codebase for better organization
- Moved core functionality to dedicated directories
- Implemented Fish-only solution for the API

### Command Line Interface Enhancements

- Added new commands for API operations:
  - `start_api`: Start the API server
  - `stop_api`: Stop the API server
  - `api_status`: Check API connection status
  - `process_noe`: Process .noe files
  - `exec_noe`: Execute commands in the noe-core repository

### Documentation

- Added API.md with detailed information on using the API
- Updated README.md to reflect the current repository structure
- Improved installation and usage instructions

## Bug Fixes

- Fixed an issue in `.gitignore` where `src/core/` files were being ignored due to a pattern matching "core" dump files

## Technical Changes

- Removed JavaScript-based API implementation in favor of Fish scripts
- Added socket-based communication using socat
- Implemented structured JSON response formatting for API calls
