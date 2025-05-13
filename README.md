# Noesis Hub v1.0.0

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
├── CONTRIBUTING.md
├── ECOSYSTEM.md
├── LICENSE (MIT License)
├── Makefile
├── README.md
├── bin/                  # Compiled binaries
├── docs/
│   ├── changelogs/
│   │   └── CHANGELOG_v1.0.0.md
│   └── guides/
│       └── MIGRATION_PLAN.md
├── examples/             # Example code and usage patterns
├── include/
│   ├── noesis_api.h      # Main API header
│   └── noesis/           # Namespaced headers
│       └── noesis_api.h
├── lib/                  # Libraries and dependencies
├── run.sh                # Central control script for bash users
├── run.fish              # Central control script for fish users
├── scripts/
│   ├── bash/             # Implementation scripts for bash
│   │   ├── add_external_lib.sh
│   │   ├── cleanup_repo.sh
│   │   ├── cleanup_structure.sh
│   │   ├── install.sh
│   │   ├── install_dependency.sh
│   │   ├── launch_noesis_env.sh
│   │   ├── link_libraries.sh
│   │   └── run.sh
│   └── fish/             # Implementation scripts for fish
│       ├── add_external_lib.fish
│       ├── cleanup_structure.fish
│       ├── cleanup_structure_aggressive.fish
│       ├── install.fish
│       ├── install_dependency.fish
│       ├── launch_noesis_env.fish
│       ├── link_libraries.fish
│       └── run.fish
├── src/
│   ├── core/             # Core functionality
│   │   ├── main.c
│   │   └── noesis_api.c
│   ├── platforms/        # Platform-specific connectors
│   └── tools/            # Utility tools and helpers
└── tests/                # Test suite
```

## Installation

### Prerequisites

- **Compiler**: GCC 6.0 or newer
- **Build System**: Make 3.81 or newer
- **Shell Environment**:
  - Bash (default): Required for the primary scripts
  - Fish (alternative): Optional for using the fish shell scripts
- **Development Tools**: 
  - git (for cloning repositories)
  - pkg-config (for managing library flags)
  - cmake (version 3.10 or newer, for building dependencies)
- **Libraries**:
  - libssl-dev (for secure connections)
  - zlib1g-dev (for compression functionality)

### Steps

1. **Install Noesis Hub**

   Using Bash:
   ```bash
   ./run.sh install
   ```

   Using Fish:
   ```fish
   ./run.fish install
   ```

   Or with the legacy scripts:
   ```bash
   ./scripts/bash/install.sh
   ```

   Using Fish (alternative):
   ```fish
   ./scripts/fish/install.fish
   ```

3. **Install Noesis Core (if not already installed)**

   If you don't have Noesis Core installed, you can use our helper scripts (optional, only needed if you want to use Noesis API features):

   Using Bash:
   ```bash
   ./run.sh install_dep
   ```

   Using Fish:
   ```fish
   ./run.fish install_dep
   ```

4. **Link Libraries with Core (Optional)**

   This step enables API connectivity with Noesis Core (if you need it):
   
   Using Bash:
   ```bash
   ./run.sh link_libraries
   ```

   Using Fish:
   ```fish
   ./run.fish link_libraries
   ```

## Running

To run Noesis Hub:

```bash
./run.sh run      # For Bash users
./run.fish run    # For Fish shell users
```

To run in a specialized Noesis environment:

```bash
./run.sh launch_env      # For Bash users
./run.fish launch_env    # For Fish shell users
```

## Using the Control Scripts

Noesis Hub provides central control scripts (`run.sh` and `run.fish`) as user-friendly ways to execute various operations without having to remember specific script paths.

### Command Line Usage

You can execute specific scripts by supplying the command name as an argument:

For Bash users:
```bash
./run.sh [command] [arguments]
```

For Fish users:
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
- `cleanup_repo` - Clean up Repository (Bash only)
- `cleanup_aggr` - Clean up Structure Aggressively (Fish only)
- `help` - Show the command menu

### Interactive Menu

If you run the control scripts without arguments, they will display an interactive menu:

```bash
./run.sh
```

or 

```fish
./run.fish
```

This will display a numbered menu where you can select the operation you want to perform.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
