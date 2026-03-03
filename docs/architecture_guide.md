# Architecture Guide

This document describes the full technical architecture of the assignment project: layers, dependencies, data flow, routing, error handling, and extension points.

## 1) Architectural Principles
- Feature-first modular structure.
- Strict separation of concerns between UI, business logic, and data access.
- `Cubit` for deterministic state transitions.
- Centralized error handling and mapping to user-facing messages.
- UI-ready `ViewModel` objects only (formatted values, no heavy mapping in widgets).
- Production-oriented decisions even for mock-data scope.

## 2) Folder Responsibility Map
- `lib/src/core`
  - Cross-cutting infrastructure: DI, router/guards, cache, storage, exceptions, constants, theme.
- `lib/src/features`
  - Product modules with independent internals (`auth`, `games`, `profile`, `main_shell`, `widgetbook`).
- `lib/src/shared`
  - Shared enums, extensions, and reusable UI components used by multiple features.

## 3) Runtime Composition (DI)
- `CPDI` is a singleton container with explicit register/resolve API.
- Initialization happens before app start in `main`, then dependencies are resolved in the widget tree.
- Key registrations:
  - Auth stack (`CPAuthLocalGateway`, `CPAuthService`, `CPAuthCubit`).
  - Games stack (`CPGamesGateway` -> `CPGamesLocalGateway` active binding).
  - Shared infra (`CPGuardedExecutor`, `CPErrorReportingService`, `CPTtlCache`, secure storage, encrypted Hive box factory).

## 4) UI and State Flow
- `Screen` widgets are shells responsible for wiring/navigation and state switching.
- `View` widgets render concrete UI and interact with user inputs.
- `Cubit` emits sealed states:
  - loading/success/error lifecycle for content features;
  - auth lifecycle for session flow.
- Retry-capable error UI is used for recoverable failures.

## 5) Data Modeling Strategy
- DTOs represent source data contracts.
- View models represent final render-ready state for UI.
- Mapping DTO -> ViewModel is performed in adapters/services, never in screen/view widgets.

## 6) Games Data Access (Important)
- Single contract:
  - `CPGamesGateway` with `Future<List<CPGameDto>> getGames()`.
- Two concrete implementations:
  - `CPGamesLocalGateway` (currently active): loads mock catalog from `assets/mock/games.json`.
  - `CPGamesApiGateway` (prepared, currently inactive): placeholder for future Dio/Retrofit API integration.

### Current binding
- DI binds `CPGamesGateway` to `CPGamesLocalGateway` now.
- This keeps production switch simple: only DI binding changes are required to move to remote API.

### Why this approach
- One stable contract for upper layers (`service`, `cubit`, `ui`).
- No duplicate abstraction hierarchies.
- Easy testability with contract-based fakes.

## 7) Caching Policy
- `CPTtlCache<T>` is the cache contract.
- Project uses persistent `CPHiveTtlCache<T>` for games catalog.
- Cache placement is in service layer (`CPGamesServiceImpl`), not in gateway layer.
- TTL is configured through app constants.

## 8) Error Handling Policy
- `CPGuardedExecutor` is used to centralize try/catch boundaries.
- Typed app exceptions are mapped to localized messages by `CPErrorMapper`.
- UI receives friendly messages and retry actions instead of raw exceptions.
- `CPErrorReportingService` is the integration point for third-party telemetry.
- Current implementation is `CPNoopErrorReportingService` (placeholder with empty body, no outbound side effects).
- `CPGuardedExecutor` reports both typed (`CPAppException`) and unknown exceptions before propagating them, so incidents are tracked even when UI message mapping falls back to generic text.

## 9) Auth and Local Security
- Auth user records are saved in encrypted Hive box.
- Box encryption key is generated and stored in platform secure storage.
- Session key is stored securely (`flutter_secure_storage`).
- Passwords are stored as hashes only.
- Biometric quick-login setup is optional and uses `local_auth`.
- Biometric mapping persistence is isolated into a dedicated `CPBiometricGateway`.
  - `CPAuthLocalGateway` is responsible only for auth user/session data.
  - `CPBiometricGateway` is responsible only for biometric identifier storage.
  - `CPAuthService` composes both gateways to resolve user by biometric mapping.
- Sign-up contains a password checkpoint step:
  - password is visually masked in UI (`******`) to avoid shoulder-surfing,
  - raw value remains available only for explicit clipboard copy action.
- Profile exposes biometric enable/disable controls, and both actions require biometric confirmation before state changes.

### Rationale for these additions
- The app is intentionally local-auth only (no server-side password recovery).
- Because credentials are device-scoped and recoverability is limited, the flow reduces lockout risk by combining:
  1. immediate password copy/save reminder after registration;
  2. optional biometric quick-login as low-friction repeat access on enrolled devices.

## 10) Routing and Guards
- `go_router` is used for declarative routing.
- Guard layer blocks unauthorized navigation and redirects based on session state.
- Route chunks are defined on screens to keep route composition explicit and consistent.

## 11) Localization
- Localization is ARB-based (`lib/l10n/*.arb`) with generated classes.
- No hardcoded user-facing literals in feature UI.
- Errors and labels are resolved through localization keys.

## 12) Performance and UI Guidelines Applied
- Builder-based lists/grids for scalable rendering.
- Reusable skeletons with shimmer-based placeholders.
- Small focused widgets; avoid large monolithic build methods.
- Responsive units via `flutter_screenutil`.

## 13) Testing Strategy (TDD)
- Workflow: test first -> minimal implementation -> refactor.
- Covered scope:
  - Core infrastructure and policies.
  - Cubit state transitions.
  - Service mapping/caching behavior.
  - Widget-level auth/profile flows.
- Goal: reduce manual QA effort and catch regressions early.

## 14) Planned API Migration Path
When backend endpoints are available:
1. Implement `CPGamesApiGateway.getGames()` with Dio/Retrofit.
2. Keep service/cubit/ui unchanged.
3. Change DI binding from `CPGamesLocalGateway` to `CPGamesApiGateway`.
4. Keep local gateway for offline fallback/testing if needed.
