# Contributing to Pangolin CLI for Home Assistant

Thank you for your interest in contributing! We welcome contributions of all kinds.

## Ways to Contribute

- 🐛 **Report bugs** - Open an issue describing the problem
- 💡 **Suggest features** - Share your ideas for improvements
- 📝 **Improve documentation** - Help make the docs clearer
- 🔧 **Submit code** - Fix bugs or add features

## Getting Started

1. Fork the repository
2. Clone your fork locally
3. Create a new branch for your changes
4. Make your changes
5. Test your changes
6. Submit a pull request

## Development Setup

### Prerequisites

- Home Assistant OS or Supervised installation
- Access to the Home Assistant terminal/SSH
- Basic knowledge of Docker and bash scripting

### Testing Changes Locally

1. Make your changes to the files in `pangolin-cli/`
2. In Home Assistant, go to **Settings** → **Add-ons** → **Pangolin CLI**
3. Click **Rebuild** to rebuild the add-on with your changes
4. Restart the add-on
5. Check the logs for any errors

## Pull Request Guidelines

### Before Submitting

- Test your changes thoroughly
- Update documentation if needed
- Add an entry to `CHANGELOG.md` under `[Unreleased]`
- Ensure your code follows the existing style

### PR Description

Please include:
- **What** - What does this PR do?
- **Why** - Why is this change needed?
- **How** - How does it work?
- **Testing** - How did you test it?

## Code Style

- Use clear, descriptive variable names
- Add comments for complex logic
- Follow bash best practices in shell scripts
- Keep changes focused and minimal

## Reporting Issues

When reporting a bug, please include:

1. **Home Assistant version**
2. **Add-on version**
3. **Architecture** (amd64, armv7, etc.)
4. **Steps to reproduce**
5. **Expected behavior**
6. **Actual behavior**
7. **Relevant logs** (from the add-on log tab)

## Questions?

Feel free to open an issue for questions or discussions.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
