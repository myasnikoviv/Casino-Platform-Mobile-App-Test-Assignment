import 'package:casino_platform_test/src/features/games/entities/game_view_model.dart';
import 'package:equatable/equatable.dart';

/// States for games catalog loading lifecycle.
enum CPGamesStatus {
  /// Data is currently loading.
  loading,

  /// Data loaded successfully.
  success,

  /// Data loading failed.
  error,
}

/// UI state for games list and detail lookup.
class CPGamesState extends Equatable {
  /// Creates [CPGamesState].
  const CPGamesState({
    required this.status,
    this.games = const <CPGameViewModel>[],
    this.errorMessage,
  });

  /// Current loading status.
  final CPGamesStatus status;

  /// Loaded games list.
  final List<CPGameViewModel> games;

  /// Localized error message.
  final String? errorMessage;

  /// Initial loading state.
  factory CPGamesState.initial() =>
      const CPGamesState(status: CPGamesStatus.loading);

  /// Immutable copy update.
  CPGamesState copyWith({
    CPGamesStatus? status,
    List<CPGameViewModel>? games,
    String? errorMessage,
  }) {
    return CPGamesState(
      status: status ?? this.status,
      games: games ?? this.games,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, games, errorMessage];
}
