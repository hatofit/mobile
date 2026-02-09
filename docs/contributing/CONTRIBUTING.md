# Contributing to HatoFit

Guidelines for contributing to the HatoFit project.

**Audience**: Contributors, Developers  
**Last Updated**: February 2026

---

## Welcome

Thank you for considering contributing to HatoFit! This document outlines the process for contributing.

---

## Ways to Contribute

| Type | Description | Difficulty |
|------|-------------|------------|
| Bug Fixes | Fix reported bugs | Beginner |
| Features | Add new features | Intermediate |
| Documentation | Improve docs | Beginner |
| Testing | Write tests | Beginner |
| Reviews | Code reviews | Advanced |

---

## Getting Started

### Prerequisites

- Flutter SDK 3.6.1+
- Dart 3.6.0+
- Git
- Android Studio / VS Code

### Development Setup

1. **Fork the repository**
2. **Clone your fork**
3. **Set up development environment**
4. **Create a feature branch**
5. **Make changes**
6. **Submit PR**

---

## Development Workflow

### 1. Create Branch

```bash
# Create from main
git checkout -b feature/your-feature-name

# Or for bug fixes
git checkout -b fix/issue-description
```

### 2. Make Changes

Follow coding standards:
- Write clean, readable code
- Add comments where needed
- Update tests

### 3. Test Changes

```bash
# Run tests
flutter test

# Run analysis
flutter analyze

# Format code
dart format .
```

### 4. Commit

Use conventional commits:

```
feat: add new workout summary view
fix: resolve Bluetooth connection timeout
docs: update API documentation
test: add workout cubit tests
```

### 5. Submit PR

1. Push to your fork
2. Create Pull Request
3. Fill PR template
4. Address review feedback

---

## Pull Request Process

### Before Submitting

- [ ] Tests pass
- [ ] Code formatted
- [ ] No lint errors
- [ ] Documentation updated
- [ ] Changelog updated

### PR Description

Include:
- Problem solved
- Changes made
- Testing performed
- Screenshots (if UI changes)

### Code Review

- Expect feedback within 2 days
- Address all comments
- Be responsive to questions

---

## Coding Standards

### Style Guide

Follow:
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Project-specific rules in `analysis_options.yaml`

### Best Practices

**DO:**
- Use meaningful names
- Keep functions small
- Write tests first
- Document public APIs

**DON'T:**
- Commit commented-out code
- Leave TODO comments
- Mix formatting changes with fixes
- Submit without testing

---

## Testing Requirements

### Test Coverage

| Component | Minimum |
|-----------|---------|
| Domain | 90% |
| Cubits | 85% |
| Data | 80% |

### Test Types

- **Unit tests**: Business logic
- **Widget tests**: UI components
- **Integration tests**: User flows

---

## Documentation

### Required Updates

| Change Type | Documentation |
|------------|---------------|
| New feature | Feature docs |
| Bug fix | Changelog |
| API change | API docs |
| New dependency | Dependencies doc |

---

## Communication

### Issue Tracking

- Search existing issues first
- Create new issue with template
- Label appropriately

### Questions

- Check existing docs
- Ask in PR comments
- Email: dev-team@hatofit.com

---

## Recognition

Contributors are acknowledged in:
- Release notes
- CONTRIBUTORS file
- App credits

---

## Code of Conduct

All contributors must follow our [Code of Conduct](CODE_OF_CONDUCT.md).

---

## Related Documents

- [Code Style](CODE_STYLE.md)
- [Pull Request Template](PULL_REQUEST_TEMPLATE.md)
- [Issue Template](ISSUE_TEMPLATE.md)
- [Architecture](../technical/ARCHITECTURE.md)