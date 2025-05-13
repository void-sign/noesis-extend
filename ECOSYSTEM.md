# Noesis Hub Ecosystem

This document provides an overview of the Noesis Hub ecosystem.

## Repository

### Noesis Hub
**Repository:** https://github.com/void-sign/noesis-hub

A fully independent platform connector hub, featuring:
- Platform integration interfaces
- Standardized connectors for external systems
- Integration tools and utilities
- API-based communication with other systems when needed

**License:** MIT License (permissive use)

## Independent Architecture

Noesis Hub follows a fully independent architecture:

1. **100% Standalone Operation:**
   - Noesis Hub operates completely independently
   - No dependencies on external systems
   - Fully self-contained functionality

2. **API-Based Communication:**
   - Well-defined API for external communication
   - Clean separation between internal and external systems
   - Robust error handling for API interactions

3. **Extension System:**
   - Standardized plugin system for extensions
   - Well-defined interface boundaries
   - Versioned API compatibility

## Key Capabilities

- **Platform Integration:** Connect various systems and platforms
- **Data Processing:** Handle data transformation and routing
- **Extension Framework:** Support for custom extensions and plugins
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
