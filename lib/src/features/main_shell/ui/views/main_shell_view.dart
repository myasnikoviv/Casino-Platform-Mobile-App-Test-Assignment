import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/ui/icons/icons.dart';
import 'package:flutter/material.dart';

/// Main shell view with bottom navigation.
class CPMainShellView extends StatelessWidget {
  /// Creates [CPMainShellView].
  const CPMainShellView({
    required this.index,
    required this.tabs,
    required this.onIndexChanged,
    super.key,
  });

  final int index;
  final List<Widget> tabs;
  final ValueChanged<int> onIndexChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: onIndexChanged,
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
    );
  }
}
