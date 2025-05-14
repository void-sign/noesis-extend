# Noesis Hub v1.1.0

This repository serves as a hub for connecting various platforms and systems to the Noesis synthetic consciousness system.

## Overview

Noesis Hub is a fully independent platform connector hub that provides standardized interfaces for integrating various systems and platforms. This repository uses the MIT license to facilitate integration with external libraries and systems. Noesis Hub is completely standalone and only communicates with Noesis via a well-defined API when needed.

## Repository Organization

Noesis Hub is an independent project:
- **Noesis Hub**: https://github.com/void-sign/noesis-hub (MIT License)
  - 100% standalone connector hub for different platforms
  - Communicates with Noesis only through API when necessary

## Structure

```
noesis-hub/
├── LICENSE (MIT License)
├── README.md
├── docs/
│   ├── API.md           # API documentation
│   └── changelogs/
│       └── CHANGELOG_v1.0.0.md
├── run.fish             # Central control script for fish users
├── src/
│   ├── api/             # API components
│   │   ├── config.fish
│   │   ├── noe_api.fish
│   │   ├── noe_processor.fish
│   │   └── request_handler.fish
│   ├── core/            # Core functionality
│   │   ├── add_external_lib.fish
│   │   ├── install_dependency.fish
│   │   └── launch_noesis_env.fish
│   └── tools/           # Utility tools and helpers
│       ├── install.fish
│       ├── link_fish.fish
│       ├── link_fish.sh
│       └── link_libraries.fish
└── tests/               # Test suite
```

## Installation

### Prerequisites

- **Shell Environment**:
  - Fish: Required for the primary scripts
- **Development Tools**: 
  - git (for cloning repositories)
  - pkg-config (for managing library flags)
  - cmake (version 3.10 or newer, for building dependencies)
  - socat (for API server functionality)
- **Libraries**:
  - libssl-dev (for secure connections)
  - zlib1g-dev (for compression functionality)

### Steps

1. **Install Noesis Hub**

   ```fish
   ./run.fish install
   ```

2. **Install Noesis Core (if not already installed)**

   If you don't have Noesis Core installed, you can use our helper scripts (optional, only needed if you want to use Noesis API features):

   ```fish
   ./run.fish install_dep
   ```

3. **Link Libraries with Core (Optional)**

   This step enables API connectivity with Noesis Core (if you need it):
   
   ```fish
   ./run.fish link_libraries
   ```

## Running

To run Noesis Hub:

```fish
./run.fish run
```

To run in a specialized Noesis environment:

```fish
./run.fish launch_env
```

### Using the API

To start the NOE API server:

```fish
./run.fish start_api
```

To check the API status:

```fish
./run.fish api_status
```

To process a .noe file:

```fish
./run.fish process_noe path/to/file.noe
```

To stop the API server:

```fish
./run.fish stop_api
```

For more information on the API, see [API Documentation](docs/API.md).

## Using the Control Scripts

Noesis Hub provides central control scripts (`run.sh` and `run.fish`) as user-friendly ways to execute various operations without having to remember specific script paths.

### Command Line Usage

You can execute specific scripts by supplying the command name as an argument:

```fish
./run.fish [command] [arguments]
```

Available commands:
- `run` - Run Noesis Hub
- `install` - Install Noesis Hub
- `link_libraries` - Link with Core Libraries
- `install_dep` - Install Core Dependencies
- `add_lib` - Add External Library
- `launch_env` - Launch Noesis Environment 
- `cleanup_struct` - Clean up Structure
- `cleanup_aggr` - Clean up Structure Aggressively
- `start_api` - Start NOE API Server
- `stop_api` - Stop NOE API Server
- `api_status` - Check NOE API Status
- `process_noe` - Process a .noe file
- `exec_noe` - Execute a command in noe-core repository
- `help` - Show the command menu

### Interactive Menu

If you run the control script without arguments, it will display an interactive menu:

```fish
./run.fish
```

This will display a numbered menu where you can select the operation you want to perform, including API operations, installation, and environment setup.

## NOE API Integration

The Noesis Hub v1.1.0 introduces a new API for communication with noe-core repositories via `.noe` files. This allows seamless integration between Noesis Hub and external systems.

### API Features

- RESTful API endpoints for communication with noe-core
- Process .noe files through a standardized interface
- Execute commands in the noe-core repository 
- Check the status of the noe-core connection

For detailed information on the API, including request formats and endpoints, see the [API Documentation](docs/API.md).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
