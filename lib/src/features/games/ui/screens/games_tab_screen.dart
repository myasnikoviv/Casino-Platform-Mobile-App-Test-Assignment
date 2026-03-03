import 'package:casino_platform_test/src/core/router/extensions/context.dart';
import 'package:casino_platform_test/src/features/games/ui/screens/game_detail_screen.dart';
import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';
import 'package:casino_platform_test/src/features/games/ui/views/games_tab_view.dart';
import 'package:flutter/widgets.dart';

/// Games tab screen shell.
class CPGamesTabScreen extends StatelessWidget {
  /// Route chunk for games tab.
  static const String pathChunk = 'games';

  /// Creates [CPGamesTabScreen].
  const CPGamesTabScreen({super.key});

  void _onOpenGame(BuildContext context, CPGameViewModel game) {
    context.pushRoute(CPGameDetailScreen.pathForId(game.id), extra: game);
  }

  @override
  Widget build(BuildContext context) {
    return CPGamesTabView(onOpenGame: (game) => _onOpenGame(context, game));
  }
}
