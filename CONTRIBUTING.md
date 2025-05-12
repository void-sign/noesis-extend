# Contributing to Noesis-Extend

Thank you for your interest in contributing to Noesis-Extend! 

## Important Notes

### Repository Split
Noesis has been split into two repositories:
1. **Noesis Core**: https://github.com/void-sign/noesis
2. **Noesis-Extend**: https://github.com/void-sign/noesis-extend (this repository)

Please ensure your contributions go to the appropriate repository.

### License
Contributions to Noesis-Extend are licensed under the MIT License. By contributing, you agree that your code will be distributed under this license.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/your-username/noesis-extend.git`
3. Install the Noesis Core dependency: `./scripts/install_dependency.fish`
4. Build the project: `./install.fish`
5. Create a branch: `git checkout -b your-feature-branch`

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

## Dependencies

This repository depends on Noesis Core. If your changes require modifications to Noesis Core, please:

1. First make a PR to the Noesis Core repository
2. Reference the Noesis Core PR in your Noesis-Extend PR
3. Only proceed with merging after the Noesis Core changes are accepted

## Communication

For questions or discussions:
- Open an issue on GitHub
- Contact the maintainer: napol@noesis.run

Thank you for contributing to Noesis-Extend!
