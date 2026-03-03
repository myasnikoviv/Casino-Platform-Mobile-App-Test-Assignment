import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';
import 'package:equatable/equatable.dart';

/// Base sealed state for games catalog lifecycle.
sealed class CPGamesState extends Equatable {
  /// Creates [CPGamesState].
  const CPGamesState();
}

/// Loading state.
class CPGamesLoadingState extends CPGamesState {
  /// Creates [CPGamesLoadingState].
  const CPGamesLoadingState();

  @override
  List<Object?> get props => const <Object?>[];
}

/// Success state with loaded games.
class CPGamesSuccessState extends CPGamesState {
  /// Creates [CPGamesSuccessState].
  const CPGamesSuccessState(this.games);

  /// Loaded games list.
  final List<CPGameViewModel> games;

  @override
  List<Object?> get props => <Object?>[games];
}

/// Error state with message and optional stale data.
class CPGamesErrorState extends CPGamesState {
  /// Creates [CPGamesErrorState].
  const CPGamesErrorState({
    required this.message,
    this.games = const <CPGameViewModel>[],
  });

  /// Localized message.
  final String message;

  /// Optional stale data.
  final List<CPGameViewModel> games;

  @override
  List<Object?> get props => <Object?>[message, games];
}
