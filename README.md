# Noesis-Extend v1.0.0

This repository contains the extensions and tools for the Noesis synthetic consciousness system, focusing on quantum computing capabilities and specialized tools.

## Overview

Noesis-Extend builds upon the Noesis Core to provide additional functionality for quantum computing, field theory, and specialized tools. This repository uses the MIT license (more permissive than the core's license) to facilitate integration with external libraries and tools.

## Repository Split

As of v1.0.0, Noesis has been split into two separate repositories:
- **Noesis Core**: https://github.com/void-sign/noesis (Custom Noesis License)
- **Noesis-Extend**: https://github.com/void-sign/noesis-extend (MIT License)

This separation allows for clearer licensing boundaries and more flexible development.

## Structure

```
noesis-extend/
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

2. Install Noesis-Extend:

```bash
./install.fish
```

If you don't have Noesis Core installed, our helper script can install it for you:

```bash
./scripts/install_dependency.fish
```

## Running

To run Noesis-Extend:

```bash
./run.fish
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
