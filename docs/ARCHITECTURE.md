# VisionMate AI - Architecture Documentation

**Version:** 1.0  
**Last Updated:** October 25, 2026  
**Status:** Active

---

## Overview

VisionMate AI uses a **Feature-First Architecture** with clear separation of concerns. The codebase is organized by features (onboarding, home, voice assistant, etc.) rather than by technical layers, making it easier to develop, test, and maintain.

---

## Project Structure

```
lib/
├── main.dart                    # Entry point - service initialization
├── app.dart                     # Root widget - theme and routing
│
├── core/                        # Shared core functionality
│   ├── constants/
│   │   ├── app_colors.dart     # WCAG AAA color palette
│   │   ├── app_sizes.dart      # Touch targets and spacing
│   │   └── app_strings.dart    # Accessibility strings
│   ├── theme/
│   │   └── app_theme.dart      # High-contrast theme
│   ├── errors/
│   │   ├── failures.dart       # Abstract failure types
│   │   └── exceptions.dart     # Custom exceptions
│   └── utils/
│       └── logger.dart          # Logging utility
│
├── services/                    # Platform abstraction layer
│   ├── audio/
│   │   ├── tts_service.dart    # Text-to-speech wrapper
│   │   └── audio_player_service.dart
│   ├── speech/
│   │   └── stt_service.dart    # Speech-to-text wrapper
│   └── platform/
│       └── haptics_service.dart
│
├── features/                    # Feature modules
│   ├── onboarding/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── welcome_screen.dart
│   │   │   └── widgets/
│   │   └── models/
│   ├── home/
│   ├── settings/
│   └── [future features...]
│
└── shared/                      # Reusable UI components
    ├── widgets/
    │   └── accessible_button.dart
    └── extensions/
        └── context_extensions.dart
```

---

## Architectural Principles

### 1. Feature Isolation
Each feature is self-contained with its own:
- Screens (full-page views)
- Widgets (feature-specific components)
- Models (feature-specific data structures)
- State management (when needed)

**Benefits:**
- Easy to add/remove features
- Clear ownership and responsibilities
- Parallel development possible

### 2. Dependency Direction

```
features/ → shared/ → core/
    ↓
services/ → core/
```

**Rules:**
- Features can use `shared/`, `services/`, and `core/`
- Shared components can only use `core/`
- Services can only use `core/`
- Features DO NOT import other features directly

### 3. Accessibility First

Every component is designed with accessibility as a requirement:
- **WCAG AAA** contrast ratios (7:1 or better)
- **72dp minimum** touch targets
- **Semantic labels** on all interactive elements
- **Screen reader** optimized text
- **Haptic feedback** for all actions

---

## Key Files and Responsibilities

### `main.dart`
**Purpose:** Application entry point

**Responsibilities:**
- Initialize Flutter binding
- Set up services (TTS, logging, etc.)
- Configure error handlers
- Launch the app

### `app.dart`
**Purpose:** Root application widget

**Responsibilities:**
- Configure Material theme
- Define navigation routes
- Set app-wide settings
- Provide dependency injection context

### `core/constants/`
**Purpose:** App-wide constants

**Files:**
- `app_colors.dart` - Color palette with contrast ratios documented
- `app_sizes.dart` - Touch targets, spacing, text sizes
- `app_strings.dart` - Accessibility labels and announcements

**Why separate?**
- Single source of truth
- Easy to maintain consistency
- Simple to update for rebranding

### `core/theme/`
**Purpose:** Theme configuration

**Files:**
- `app_theme.dart` - Complete Material theme

**Benefits:**
- Enforces accessibility standards
- Consistent styling across app
- Easy to test theme compliance

### `services/`
**Purpose:** Abstract platform-specific functionality

**Pattern:**
```dart
abstract class TtsService {
  Future<void> speak(String text);
  Future<void> stop();
}

class TtsServiceImpl implements TtsService {
  // Implementation using flutter_tts
}
```

**Why this pattern?**
- Testable (use mocks in tests)
- Swappable (change implementation without changing features)
- Platform-independent (features don't know about plugins)

### `features/`
**Purpose:** Self-contained feature modules

**Structure:**
```
feature_name/
├── presentation/       # UI layer
│   ├── screens/       # Full screens
│   └── widgets/       # Feature-specific widgets
├── models/            # Data structures
└── services/          # Feature-specific services (optional)
```

**Example: onboarding/**
- `presentation/screens/welcome_screen.dart` - Welcome UI
- More screens will be added as the feature grows

### `shared/widgets/`
**Purpose:** Reusable UI components

**Current widgets:**
- `accessible_button.dart` - Standard button with accessibility features

**Guidelines:**
- Only visual components (no business logic)
- Highly reusable across features
- Fully documented with usage examples

---

## Development Workflow

### Adding a New Feature

1. **Create feature folder:**
   ```
   lib/features/new_feature/
   ├── presentation/screens/
   └── models/
   ```

2. **Implement screens:**
   - Use `shared/widgets/` for common UI
   - Follow accessibility guidelines
   - Add semantic labels

3. **Add route in `app.dart`:**
   ```dart
   routes: {
     '/new-feature': (context) => const NewFeatureScreen(),
   }
   ```

4. **Write tests:**
   ```
   test/features/new_feature/
   └── new_feature_screen_test.dart
   ```

### Adding a Shared Widget

1. **Create widget in `shared/widgets/`:**
   ```dart
   class AccessibleCard extends StatelessWidget {
     // Implementation with accessibility features
   }
   ```

2. **Document usage:**
   - Add doc comments
   - Include example in widget file

3. **Write widget tests:**
   ```
   test/shared/widgets/
   └── accessible_card_test.dart
   ```

### Adding a Service

1. **Define interface:**
   ```dart
   abstract class NewService {
     Future<void> doSomething();
   }
   ```

2. **Implement:**
   ```dart
   class NewServiceImpl implements NewService {
     // Use platform plugins here
   }
   ```

3. **Initialize in `main.dart`:**
   ```dart
   final newService = NewServiceImpl();
   ```

4. **Write tests with mocks:**
   ```dart
   class MockNewService extends Mock implements NewService {}
   ```

---

## State Management

### Current Strategy: Local State

**Approach:**
- Use `StatefulWidget` for screens with local state
- Pass callbacks for parent-child communication
- Services accessed via dependency injection

**When this is sufficient:**
- State is scoped to a single screen
- No complex state sharing between features
- Simple data flows

### Future Strategy: BLoC/Provider

**When to migrate:**
- State needs to be shared across 3+ screens
- Complex business logic emerges
- Async operations become more intricate

**Recommended:** Provider or BLoC (as per implementation plan)

---

## Error Handling

### Pattern

**Define failures:**
```dart
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServiceFailure extends Failure {
  const ServiceFailure(super.message);
}
```

**Handle in UI:**
```dart
try {
  await service.doSomething();
} on ServiceException catch (e) {
  // Show accessible error feedback
  showAccessibleError(context, e.message);
}
```

---

## Testing Strategy

### Unit Tests
- Core utilities (`core/utils/`)
- Service logic (`services/`)
- Data models (`models/`)

### Widget Tests
- Shared widgets (`shared/widgets/`)
- Feature screens (`features/*/presentation/`)

### Integration Tests
- End-to-end user flows
- Accessibility compliance (TalkBack)

### Accessibility Tests
- Every screen tested with TalkBack enabled
- Contrast ratios verified
- Touch target sizes validated

---

## File Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Screens | `*_screen.dart` | `welcome_screen.dart` |
| Widgets | Descriptive name | `accessible_button.dart` |
| Services | `*_service.dart` | `tts_service.dart` |
| Models | Entity name | `user_preferences.dart` |
| Constants | `app_*.dart` | `app_colors.dart` |
| Tests | `*_test.dart` | `welcome_screen_test.dart` |

---

## Git Workflow

### Branch Strategy
- `main` - Production-ready code
- `feature/*` - Feature development
- `fix/*` - Bug fixes

### Commit Messages
Use Conventional Commits format:

```
feat(onboarding): add welcome screen
fix(theme): correct contrast ratio for secondary text
docs(architecture): update folder structure diagram
refactor(button): extract accessible button component
test(welcome): add widget tests for welcome screen
```

---

## Next Steps

### Immediate (Phase 2)
1. Implement `TtsService` wrapper
2. Implement `HapticsService`
3. Add `HomeScreen` in `features/home/`

### Short-term (Phase 3-4)
1. Implement voice interaction
2. Add camera/OCR features
3. Build settings screen

### Long-term (Phase 5+)
Follow the implementation plan in `docs/06_IMPLEMENTATION_PLAN.md`

---

## Decisions and Trade-offs

### Why Feature-First over Layer-First?

**Feature-First (chosen):**
```
features/
  onboarding/
    screens/
    widgets/
    models/
```

**Layer-First (not chosen):**
```
screens/
  welcome_screen.dart
  home_screen.dart
widgets/
  onboarding_widget.dart
  home_widget.dart
```

**Reasoning:**
- Features are isolated (easier to remove/modify)
- Clear ownership (each team member owns a feature)
- Scales better (10+ features don't become a mess)
- Aligns with how users think (features, not technical layers)

### Why Services Layer?

**Benefits:**
- Platform independence (features don't know about plugins)
- Testability (mock services in tests)
- Flexibility (swap implementations easily)

**Trade-off:**
- Extra abstraction layer
- Slightly more boilerplate

**Verdict:** Worth it for testability and maintainability

---

## Resources

- [Flutter Accessibility Guide](https://docs.flutter.dev/development/accessibility-and-localization/accessibility)
- [WCAG 2.2 Guidelines](https://www.w3.org/WAI/WCAG22/quickref/)
- [Material Design Accessibility](https://m3.material.io/foundations/accessible-design)
- VisionMate AI Implementation Plan: `docs/06_IMPLEMENTATION_PLAN.md`

---

## Changelog

### Version 1.0 (October 25, 2026)
- Initial architecture document
- Feature-first structure defined
- Core constants and theme implemented
- Welcome screen migrated to features
- Accessible button component created

---

**Maintained by:** VisionMate AI Development Team  
**Questions?** Refer to this document or ask the lead architect.
