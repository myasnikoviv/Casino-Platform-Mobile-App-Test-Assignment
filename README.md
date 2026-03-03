# Casino Platform Mobile App (Flutter Test Assignment)

Production-oriented implementation of a local-auth casino platform app, aligned with the provided task and extended with scalability/security/documentation decisions.

## Run
1. `flutter pub get`
2. `flutter run`

## Tech Stack
- `flutter_bloc`: reactive state management via Cubit.
- `go_router`: centralized routing and auth guard redirects.
- `hive` + `hive_flutter`: local encrypted data persistence.
- `flutter_secure_storage`: secure key/session storage.
- `crypto`: password hashing (`sha256`).
- `flutter_screenutil`: responsive sizing.
- `local_auth`: biometric quick login setup/authentication.
- `equatable`: value equality for immutable state/models.
- `intl`: date formatting.
- `flutter_localizations`: localization delegates.

## Implemented Features
- Local auth flow:
  - Login (email + password validation).
  - Sign-up (name/email/password/confirm + duplicate email guard).
  - Password hash persistence.
  - Auto-session on successful registration.
  - Logout from profile.
- Extra auth UX:
  - Show/hide password.
  - Strong password generator.
  - Password save/copy checkpoint after sign-up.
  - Optional biometric one-tap login setup (skippable).
- Main shell:
  - Bottom navigation tabs: Home, Games, Profile.
- Home/Games:
  - Hero promo section with 2 banners.
  - Game grid with exactly 4 columns.
  - 12 mock games loaded from JSON.
  - Flip animation on game card tap + Hero transition to details.
- Game details:
  - Large header image, category badge, provider, RTP, volatility, description, Play Now CTA.
- Profile:
  - Name/email/avatar initials.
  - Member since + account ID.
  - Logout action.
  - Dev-only Widgetbook entry.
- Widgetbook-like screen:
  - Shared widgets preview and theme token preview.

## Architecture
See detailed decisions in:
- [docs/architecture_decisions.md](docs/architecture_decisions.md)

High-level structure:
- `lib/src/core`: infrastructure and cross-cutting concerns.
- `lib/src/features`: feature modules with layered internals.
- `lib/src/shared`: reusable widgets and shared primitives.

## Data and Caching
- Mock game catalog source: `assets/mock/games.json`.
- Repository-level in-memory TTL cache for game list.
- DTO -> ViewModel adaptation in service layer.

## Quality Gates
- `flutter analyze`: **passed**
- `flutter test`: **passed**

## Testing (TDD)
- The codebase is developed with a test-driven mindset for core logic and state transitions.
- Covered areas:
  - Unit tests:
    - cache and infrastructure behavior (`TtlCache`, `GuardedExecutor`, `AuthGuard`, `ErrorMapper`),
    - auth form validators and utility classes (`HashUtils`, password generator),
    - state management (`AuthCubit`, `GamesCubit`),
    - DTO -> ViewModel adaptation (`GamesService`).
  - Widget/integration-like tests:
    - login and sign-up validation flows,
    - profile rendering with authenticated state.
- Current suite: **31 passing tests**.
- Goal: reduce manual QA load by catching regressions at logic/state/UI-validation levels before runtime testing.

## Notes
- This project intentionally uses local-only auth with no backend.
- Security is layered (secure key storage + encrypted Hive + hashed passwords), but fully compromised devices remain a general client-side limitation.
