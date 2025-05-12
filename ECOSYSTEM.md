# Noesis Project Ecosystem

This document provides an overview of the Noesis project ecosystem, which consists of independent yet compatible components.

## Repositories

### 1. Noesis Core
**Repository:** https://github.com/void-sign/noesis

The core of the Noesis synthetic consciousness engine, featuring:
- Emotion processing
- Logic processing
- Memory management
- Perception processing
- Intent processing

**License:** Custom Noesis License (requires attribution and profit-sharing for commercial use)

### 2. Noesis Hub
**Repository:** https://github.com/void-sign/noesis-hub

An independent connector hub for the Noesis ecosystem, featuring:
- Platform integration interfaces
- Standardized connectors for external systems
- Integration tools and utilities

**License:** MIT License (permissive use)

## Independent Extension Architecture

Noesis Hub now follows an independent extension architecture:

1. **Optional Core Integration:**
   - Noesis Hub can operate independently or integrate with Noesis Core
   - Integration is handled through a plugin architecture
   - No hard dependency on Noesis Core

2. **Flexible Configuration:**
   - Environment variable `NOESIS_CORE_PATH` is optional
   - Extensions auto-discover core functionality when available
   - Graceful fallback to standalone mode when core is unavailable

3. **Extension API:**
   - Standardized API for all Noesis extensions
   - Well-defined interface boundaries
   - Versioned API compatibility

## Choosing the Right Components

- **Noesis Core:** For core consciousness simulation functionality
- **Noesis Hub:** For quantum computing and field theory extensions (can be used independently)
- **Combined Use:** For maximum functionality with both components working together
- **Custom Integration:** Mix and match with your own components using the extension API

## Integration Methods

Noesis Hub offers multiple integration options:

1. **Standalone Mode:**
   - Use Noesis Hub completely independently
   - All quantum functionality works without Core
   - Access through standard APIs defined in `include/quantum`

2. **Plugin Mode:**
   - Dynamically discovers and connects to Noesis Core at runtime
   - `link_libraries.fish` creates optional connections if Core is detected
   - Enables advanced hybrid consciousness-quantum algorithms

3. **API Compatibility:**
   - All extensions follow the same API contract
   - Versioned interfaces ensure forward compatibility
   - Custom extensions can be developed using the same pattern

## Migration from Previous Versions

If you were using the previous integrated version of Noesis, please see the [MIGRATION.md](MIGRATION.md) guide for detailed migration instructions, including how to adapt to the new independent extension architecture.
