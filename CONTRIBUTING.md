# Contributing to Noesis Hub

Thank you for your interest in contributing to Noesis Hub. 

## Important Notes

### Repository Split
Noesis has been split into two repositories:
1. **Noesis Core**: https://github.com/void-sign/noesis
2. **Noesis Hub**: https://github.com/void-sign/noesis-hub (this repository)

Please ensure your contributions go to the appropriate repository.

### Independent Extension Architecture
Noesis Hub now follows an independent extension architecture:
- Can operate standalone without requiring Noesis Core
- Can integrate with Noesis Core through a plugin architecture when available
- Uses a standardized Extension API for compatibility

### License
Contributions to Noesis Hub are licensed under the MIT License. By contributing, you agree that your code will be distributed under this license.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/void-sign/noesis-hub.git`
3. Build the project in standalone mode: `./install.fish`
   - Optionally, if you want Core integration: `./fish_scripts/install_dependency.fish`
4. Create a branch: `git checkout -b your-feature-branch`

## Making Changes

1. Make your changes following the coding conventions in the project
2. Test your changes: `make test`
3. Commit your changes: `git commit -m "Description of changes"`
4. Push to your fork: `git push origin your-feature-branch`
5. Submit a Pull Request

## Code Style

- Follow the existing code style in the project
- Comment your code where appropriate
- Write clear commit messages

## Testing

- Add tests for new features
- Test in both standalone and integrated modes when applicable
- Ensure all tests pass before submitting
- Include documentation for new features

## Integration with Noesis Core

Noesis Hub follows an independent extension architecture that can operate with or without Noesis Core:

1. **Standalone Mode:** All quantum functionality works independently without Core
2. **Plugin Mode:** Can dynamically connect to Noesis Core if available

If your changes affect Core integration:

1. Make a PR to the Noesis Core repository if needed
2. Reference any Noesis Core PR in your Noesis Hub PR
3. Ensure your changes respect the optional nature of Core integration
4. Test functionality both with and without Core present

## Communication

For questions or discussions:
- Open an issue on GitHub
- Contact the maintainer: napol@noesis.run

Thank you for contributing to Noesis Hub.
