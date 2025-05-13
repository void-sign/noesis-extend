# Noesis Hub v1.0.0

This repository serves as a hub for connecting various platforms and systems to the Noesis synthetic consciousness system.

## Overview

Noesis Hub is a platform connector hub that provides standardized interfaces for integrating different platforms with Noesis Core. This repository uses the MIT license (more permissive than the core's license) to facilitate integration with external libraries and systems.

## Repository Organization

As of v1.0.0, Noesis has been reorganized:
- **Noesis Core**: https://github.com/void-sign/noesis (Noesis License)
- **Noesis Hub**: https://github.com/void-sign/noesis-hub (MIT License)
  - Focused on being a connector hub for different platforms

This organization allows Noesis Core to maintain all core functionality, while Noesis Hub serves as a flexible integration point for various external platforms.

## Structure

```
noesis-hub/
├── CONTRIBUTING.md
├── ECOSYSTEM.md
├── LICENSE (MIT License)
├── Makefile
├── README.md
├── changelogs/
│   └── CHANGELOG_v1.0.0.md
├── docs/
│   ├── changelogs/
│   └── guides/
├── include/
│   └── noesis_api.h
├── scripts/
│   ├── bash/
│   │   ├── add_external_lib.sh
│   │   ├── install.sh
│   │   ├── install_dependency.sh
│   │   ├── launch_noesis_env.sh
│   │   ├── link_libraries.sh
│   │   └── run.sh
│   └── fish/
│       ├── add_external_lib.fish
│       ├── install.fish
│       ├── install_dependency.fish
│       ├── launch_noesis_env.fish
│       ├── link_libraries.fish
│       └── run.fish
├── src/
│   ├── core/
│   ├── platforms/
│   └── tools/
├── tests/
├── run.sh
└── run.fish
```

## Installation

### Prerequisites

- **Noesis Core**: Either installed or path available (see installation steps)
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

1. **Set Up Noesis Core**
   
   Either install Noesis Core first, or set the environment variable to point to your existing installation:

   For Bash (default):
   ```bash
   export NOESIS_CORE_PATH=/path/to/noesis
   ```

   For Fish (alternative):
   ```bash
   set -gx NOESIS_CORE_PATH /path/to/noesis
   ```

2. **Install Noesis Hub**

   Using Bash (default):
   ```bash
   ./scripts/bash/install.sh
   ```

   Using Fish (alternative):
   ```bash
   ./scripts/fish/install.fish
   ```

3. **Install Noesis Core (if not already installed)**

   If you don't have Noesis Core installed, you can use our helper scripts:

   Using Bash (default):
   ```bash
   ./scripts/bash/install_dependency.sh
   ```

   Using Fish (alternative):
   ```bash
   ./scripts/fish/install_dependency.fish
   ```

4. **Link Libraries with Core**

   This step ensures proper linkage between Noesis Hub and Core:
   
   Using Bash (default):
   ```bash
   ./scripts/bash/link_libraries.sh
   ```

   Using Fish (alternative):
   ```bash
   ./scripts/fish/link_libraries.fish
   ```

## Running

To run Noesis Hub:

```bash
./run.sh      # For Bash users
./run.fish    # For Fish shell users
```

To run in a specialized Noesis environment:

```bash
./scripts/bash/launch_noesis_env.sh   # For Bash users
./scripts/fish/launch_noesis_env.fish # For Fish shell users
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
