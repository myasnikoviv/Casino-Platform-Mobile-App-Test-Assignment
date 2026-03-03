import 'package:casino_platform_test/src/core/di/service_locator.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/games/cubit/games_cubit.dart';
import 'package:casino_platform_test/src/features/games/screens/games_tab_screen.dart';
import 'package:casino_platform_test/src/features/games/screens/home_tab_screen.dart';
import 'package:casino_platform_test/src/features/profile/screens/profile_screen.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Main authenticated shell with bottom navigation tabs.
class CPMainShellScreen extends StatefulWidget {
  /// Route path for shell screen.
  static const String routePath = CPRoutePaths.shell;

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
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: context.l10n.text('homeTab'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.casino_outlined),
              selectedIcon: const Icon(Icons.casino),
              label: context.l10n.text('gamesTab'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person),
              label: context.l10n.text('profileTab'),
            ),
          ],
        ),
      ),
    );
  }
}
