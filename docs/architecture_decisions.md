# Architecture Decisions

Companion full specification:
- [architecture_guide.md](architecture_guide.md)

## 1) Architecture Style
- **Feature-first layered architecture** is used.
- `core/` contains global infrastructure: routing, theme, localization, secure storage, errors, DI, cache.
- `features/` contains business modules: `auth`, `games`, `profile`, `main_shell`, `widgetbook`.
- `shared/` contains reusable UI widgets and shared enums/extensions.

## 2) State Management Choice
- **Cubit (flutter_bloc)** was selected.
- Why:
  - Explicit state transitions (`loading/error/success`, auth lifecycle).
  - Small, predictable public APIs for screens.
  - Easy testing and no business logic in `build()` methods.

## 3) Routing and Guarding
- **go_router** is used for typed navigation and centralized redirect logic.
- `AuthGuard` enforces:
  - unauthenticated users are redirected to login,
  - authenticated users cannot go back to login/sign-up,
  - onboarding routes are protected from anonymous access.

## 4) Local Auth Storage Security
- User records are persisted in a **Hive encrypted box**.
- The 256-bit Hive AES key is generated once and stored in **flutter_secure_storage**.
- Session state is stored in secure storage (session email key).
- Biometric identifier mapping is stored through dedicated biometric gateway storage.
- Passwords are persisted only as **SHA-256 hashes** (never plaintext).

### Security note
- Secure storage relies on platform keychain/keystore mechanisms.
- If a device is fully compromised (rooted/jailbroken + unlocked secrets), no client-only solution is absolute.
- For this assignment scope, layered local protection is applied and documented.

## 5) Error Handling Policy
- `GuardedExecutor` is used as centralized `try/catch` policy.
- Domain/infrastructure exceptions are represented by sealed `AppException` types.
- `ErrorMapper` converts typed exceptions into localized, user-friendly messages.
- UI error blocks always provide a retry path for recoverable states.
- `CPErrorReportingService` defines telemetry integration boundary for third-party monitoring providers (Sentry/Crashlytics style).
- Current app wiring uses `CPNoopErrorReportingService`; production provider can be attached by DI-only swap.
- Every exception caught by `GuardedExecutor` is reported through `CPErrorReportingService`, including cases that end up as generic fallback UI messages.

## 6) Mock Data and Data Pipeline
- Games are stored in `assets/mock/games.json`.
- Data pipeline:
  1. `CPGamesGateway` defines a single data access contract.
  2. `CPGamesLocalGateway` (active) loads DTOs from bundled JSON.
  3. `CPGamesApiGateway` (prepared, not active) is reserved for future Dio/Retrofit integration.
  4. Service applies TTL cache policy.
  5. Service adapts DTOs to UI-ready ViewModels (formatted labels, localized enums).

## 7) Caching Strategy
- `TtlCache<T>` defines cache contract with expiration.
- `CPHiveTtlCache<T>` is used for persistent TTL caching in this project.
- Games catalog TTL is currently 5 minutes.
- Cache invalidates on expiration or explicit clear.
- This design is extensible for high-volume lists and data refresh policies.

## 8) UI Performance Rules Applied
- Grid/list rendering uses builder-based APIs and cache extent.
- Widgets are decomposed into small files/components.
- Screen-specific helper methods returning widgets are avoided in favor of standalone widget classes.
- ScreenUtil is used for responsive sizing (`.w`, `.h`, `.sp`).

## 9) Localization Strategy
- No UI literals are hardcoded in screen code.
- English locale is implemented via centralized key map (`AppLocalizations`).
- Error messages and UI labels are mapped through localization keys.

## 10) Dev-only Widgetbook Route
- Internal widgetbook-like screen is exposed from Profile.
- Visibility is restricted to `kDebugMode` to prevent production exposure.

## 11) Assignment-specific Enhancements Added
- Password save/copy checkpoint after registration with masked display (`******`) and explicit copy CTA.
- Optional biometric one-tap login enrollment (skippable).
- Dedicated biometric service flow via `CPBiometricGateway` + `CPAuthService` orchestration, including profile-level enable/disable guarded by biometric identity confirmation.
- Flip tap animation + Hero continuity for game card to details transition.

### Why these auth UX improvements
- The assignment uses local-only auth with no backend recovery channel, so forgotten credentials are a realistic risk.
- Password copy checkpoint reduces lockout probability by nudging users to store credentials immediately.
- Biometric quick login provides a safe fallback path for repeated access on the same trusted device.

## 12) Test Strategy (TDD-first)
- Development follows a test-driven flow for critical logic:
  1. Define expected behavior in test.
  2. Implement minimal code to satisfy it.
  3. Refactor while keeping tests green.
- Automated coverage focuses on minimizing manual QA effort by validating:
  - core infrastructure (`TtlCache`, `AuthGuard`, `GuardedExecutor`, `ErrorMapper`, generators),
  - auth validation and auth state transitions (`AuthCubit`),
  - games adaptation/loading states (`GamesService`, `GamesCubit`),
  - UI form behavior and user-facing validation states (widget tests for auth/profile screens).
- Current suite includes both:
  - unit tests for deterministic business rules and infrastructure,
  - widget/integration-like flow tests for screen interactions and validation messages.
