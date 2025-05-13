# Contributing to Noesis Hub

Thank you for your interest in contributing to Noesis Hub. 

## Important Notes

### Repository Independence
Noesis Hub is fully independent:
1. **Noesis Hub**: https://github.com/void-sign/noesis-hub (this repository)
   - 100% standalone platform for integration
   - Only communicates with Noesis via well-defined API when needed

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
3. Build the project: `./run.fish install`
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
- Ensure all tests pass before submitting
- Include documentation for new features
- If adding API-related features, test with appropriate mocks

## API Integration

Noesis Hub is 100% independent but may communicate with Noesis via a well-defined API:

1. **Standalone Operation:** All functionality works independently
2. **API Communication:** Uses well-defined API endpoints when communication is needed

When working with API-related code:

1. Use proper abstraction layers
2. Implement robust error handling for API calls
3. Ensure the system works even if the API is unavailable
4. Add appropriate tests with API mocks

## Communication

For questions or discussions:
- Open an issue on GitHub
- Contact the maintainer: napol@noesis.run

Thank you for contributing to Noesis Hub.
