import 'package:casino_platform_test/src/core/di/di.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_cubit.dart';
import 'package:casino_platform_test/src/features/games/services/games_service.dart';
import 'package:casino_platform_test/src/features/games/ui/screens/games_tab_screen.dart';
import 'package:casino_platform_test/src/features/games/ui/screens/home_tab_screen.dart';
import 'package:casino_platform_test/src/features/main_shell/ui/views/main_shell_view.dart';
import 'package:casino_platform_test/src/features/profile/ui/screens/profile_screen.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Main authenticated shell screen.
class CPMainShellScreen extends StatefulWidget {
  /// Route chunk for shell screen.
  static const String pathChunk = 'main';

  /// Route path for shell screen.
  static const CPRoutePath routePath = CPRoutePath('/$pathChunk');

  /// Creates [CPMainShellScreen].
  const CPMainShellScreen({super.key});

  @override
  State<CPMainShellScreen> createState() => _CPMainShellScreenState();
}

class _CPMainShellScreenState extends State<CPMainShellScreen> {
  final CPGamesCubit _gamesCubit =
      CPGamesCubit(CPDI.resolveDependency<CPGamesService>());
  int _index = 0;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) {
      return;
    }
    _loaded = true;
    _gamesCubit.loadGames(context.l10n);
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> tabs = <Widget>[
      CPHomeTabScreen(),
      CPGamesTabScreen(),
      CPProfileScreen(),
    ];

    return BlocProvider<CPGamesCubit>(
      create: (_) => _gamesCubit,
      child: CPMainShellView(
        index: _index,
        tabs: tabs,
        onIndexChanged: (value) => setState(() => _index = value),
      ),
    );
  }
}
