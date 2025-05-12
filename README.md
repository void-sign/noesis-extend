# Noesis Hub v1.0.0

This repository serves as a hub for connecting various platforms and systems to the Noesis synthetic consciousness system.

## Overview

Noesis Hub is a platform connector hub that provides standardized interfaces for integrating different platforms with Noesis Core. This repository uses the MIT license (more permissive than the core's license) to facilitate integration with external libraries and systems. All quantum functionality has been moved back to the Noesis Core repository.

## Repository Organization

As of v1.0.0, Noesis has been reorganized:
- **Noesis Core**: https://github.com/void-sign/noesis (Noesis License)
  - Now includes all quantum functionality previously in Noesis Hub
- **Noesis Hub**: https://github.com/void-sign/noesis-hub (MIT License)
  - Now focused on being a connector hub for different platforms

This organization allows Noesis Core to maintain all core functionality including quantum components, while Noesis Hub serves as a flexible integration point for various external platforms.

## Structure

```
noesis-hub/
├── LICENSE (MIT License)
├── README.md
├── data/
│   └── gate_defs.h
├── include/
│   └── quantum/
│       ├── backend.h
│       ├── compiler.h
│       ├── export.h
│       ├── quantum.h
│       └── field/
│           └── quantum_field.h
├── source/
│   ├── quantum/
│   │   ├── backend_ibm.c
│   │   ├── backend_stub.c
│   │   ├── compiler.c
│   │   ├── export_json.c
│   │   ├── export_qasm.c
│   │   ├── quantum.c
│   │   └── field/
│   │       └── quantum_field.c
│   └── tools/
│       ├── qbuild.c
│       └── qrun.c
└── tests/
    └── qlogic_tests.c
```

## Installation

### Prerequisites

- Noesis Core installed or available
- GCC compiler
- Make
- Fish shell (recommended)

### Steps

1. First, ensure you have Noesis Core installed or set `NOESIS_CORE_PATH` to point to your Noesis Core installation:

```bash
set -gx NOESIS_CORE_PATH /path/to/noesis
```

2. Install Noesis Hub:

```bash
./install.fish
```

If you don't have Noesis Core installed, our helper script can install it for you:

```bash
./scripts/install_dependency.fish
```

## Running

To run Noesis Hub:

```bash
./run.fish
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
