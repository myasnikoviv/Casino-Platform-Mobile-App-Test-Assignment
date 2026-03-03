import 'package:casino_platform_test/src/features/games/domain/entities/game_view_model.dart';
import 'package:equatable/equatable.dart';

/// States for games catalog loading lifecycle.
enum GamesStatus {
  /// Data is currently loading.
  loading,

  /// Data loaded successfully.
  success,

  /// Data loading failed.
  error,
}

/// UI state for games list and detail lookup.
class GamesState extends Equatable {
  /// Creates [GamesState].
  const GamesState({
    required this.status,
    this.games = const <GameViewModel>[],
    this.errorMessage,
  });

  /// Current loading status.
  final GamesStatus status;

  /// Loaded games list.
  final List<GameViewModel> games;

  /// Localized error message.
  final String? errorMessage;

  /// Initial loading state.
  factory GamesState.initial() => const GamesState(status: GamesStatus.loading);

  /// Immutable copy update.
  GamesState copyWith({
    GamesStatus? status,
    List<GameViewModel>? games,
    String? errorMessage,
  }) {
    return GamesState(
      status: status ?? this.status,
      games: games ?? this.games,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, games, errorMessage];
}
