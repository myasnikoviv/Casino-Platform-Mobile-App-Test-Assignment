import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/games/presentation/cubit/games_cubit.dart';
import 'package:casino_platform_test/src/features/games/presentation/screens/games_tab_screen.dart';
import 'package:casino_platform_test/src/features/games/presentation/screens/home_tab_screen.dart';
import 'package:casino_platform_test/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Main authenticated shell with bottom navigation tabs.
class MainShellScreen extends StatefulWidget {
  /// Route path for shell screen.
  static const String routePath = RoutePaths.shell;

  /// Creates [MainShellScreen].
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _index = 0;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) {
      return;
    }
    _initialized = true;
    context.read<GamesCubit>().loadGames(context.l10n);
  }

  void _onIndexChanged(int value) {
    setState(() => _index = value);
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> tabs = <Widget>[
      HomeTabScreen(),
      GamesTabScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
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
    );
  }
}
