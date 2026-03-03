import 'package:casino_platform_test/src/core/router/extensions/context.dart';
import 'package:casino_platform_test/src/features/games/ui/screens/game_detail_screen.dart';
import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';
import 'package:casino_platform_test/src/features/games/ui/views/home_tab_view.dart';
import 'package:flutter/widgets.dart';

/// Home tab screen shell.
class CPHomeTabScreen extends StatelessWidget {
  /// Route segment for home tab.
  static const String routeSegment = 'home';

  /// Creates [CPHomeTabScreen].
  const CPHomeTabScreen({super.key});

  void _onOpenGame(BuildContext context, CPGameViewModel game) {
    context.pushRoute(CPGameDetailScreen.pathForId(game.id), extra: game);
  }

  @override
  Widget build(BuildContext context) {
    return CPHomeTabView(onOpenGame: (game) => _onOpenGame(context, game));
  }
}
