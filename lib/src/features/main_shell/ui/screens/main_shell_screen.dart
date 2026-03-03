import 'package:casino_platform_test/src/core/di/di.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_cubit.dart';
import 'package:casino_platform_test/src/features/games/ui/screens/games_tab_screen.dart';
import 'package:casino_platform_test/src/features/games/ui/screens/home_tab_screen.dart';
import 'package:casino_platform_test/src/features/profile/ui/screens/profile_screen.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/ui/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Main authenticated shell with bottom navigation tabs.
class CPMainShellScreen extends StatefulWidget {
  /// Route chunk for shell screen.
  static const String pathChunk = 'main';

  /// Route path for shell screen.
  static const CPRoutePath routePath = CPRoutePath(
    '/$pathChunk',
  );

  /// Creates [CPMainShellScreen].
  const CPMainShellScreen({super.key});

  @override
  State<CPMainShellScreen> createState() => _CPMainShellScreenState();
}

class _CPMainShellScreenState extends State<CPMainShellScreen> {
  final CPDI _di = CPDI();
  late final CPGamesCubit _gamesCubit;
  int _index = 0;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _gamesCubit = CPGamesCubit(_di.resolve());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) {
      return;
    }
    _loaded = true;
    _gamesCubit.loadGames(context.l10n);
  }

  void _onIndexChanged(int value) {
    setState(() => _index = value);
  }

  @override
  void dispose() {
    _gamesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> tabs = <Widget>[
      CPHomeTabScreen(),
      CPGamesTabScreen(),
      CPProfileScreen(),
    ];

    return BlocProvider<CPGamesCubit>.value(
      value: _gamesCubit,
      child: Scaffold(
        body: IndexedStack(index: _index, children: tabs),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: _onIndexChanged,
          destinations: <NavigationDestination>[
            NavigationDestination(
              icon: const Icon(CPIcons.homeOutlined),
              selectedIcon: const Icon(CPIcons.home),
              label: context.l10n.homeTab,
            ),
            NavigationDestination(
              icon: const Icon(CPIcons.gamesOutlined),
              selectedIcon: const Icon(CPIcons.games),
              label: context.l10n.gamesTab,
            ),
            NavigationDestination(
              icon: const Icon(CPIcons.profileOutlined),
              selectedIcon: const Icon(CPIcons.profile),
              label: context.l10n.profileTab,
            ),
          ],
        ),
      ),
    );
  }
}
