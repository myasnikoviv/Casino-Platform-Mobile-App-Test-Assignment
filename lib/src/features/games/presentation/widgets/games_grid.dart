import 'package:casino_platform_test/src/features/games/domain/entities/game_view_model.dart';
import 'package:casino_platform_test/src/features/games/presentation/widgets/game_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable 4-column games grid for home and games tabs.
class GamesGrid extends StatelessWidget {
  /// Creates [GamesGrid].
  const GamesGrid({
    required this.games,
    required this.onOpenGame,
    super.key,
  });

  /// Games to render.
  final List<GameViewModel> games;

  /// Callback when game card is selected.
  final ValueChanged<GameViewModel> onOpenGame;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      cacheExtent: 300,
      itemCount: games.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (BuildContext context, int index) {
        final GameViewModel game = games[index];
        return GameCard(
          game: game,
          onOpen: () => onOpenGame(game),
        );
      },
    );
  }
}
