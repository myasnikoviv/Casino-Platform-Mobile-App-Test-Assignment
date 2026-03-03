import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/ui/app_navigation_destination.dart';
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
      body: SafeArea(
        top: true,
        bottom: false,
        child: IndexedStack(index: index, children: tabs),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: onIndexChanged,
        destinations: <NavigationDestination>[
          CPAppNavigationDestination(
            iconType: CPIconType.homeOutlined,
            selectedIconType: CPIconType.home,
            label: context.l10n.homeTab,
          ),
          CPAppNavigationDestination(
            iconType: CPIconType.gamesOutlined,
            selectedIconType: CPIconType.games,
            label: context.l10n.gamesTab,
          ),
          CPAppNavigationDestination(
            iconType: CPIconType.profileOutlined,
            selectedIconType: CPIconType.profile,
            label: context.l10n.profileTab,
          ),
        ],
      ),
    );
  }
}
