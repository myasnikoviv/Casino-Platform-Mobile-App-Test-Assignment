import 'package:casino_platform_test/src/shared/ui/icons/icons.dart';
import 'package:flutter/material.dart';

/// Navigation destination with app icon abstraction.
class CPAppNavigationDestination extends NavigationDestination {
  /// Creates [CPAppNavigationDestination].
  CPAppNavigationDestination({
    required super.label,
    required CPIconType iconType,
    required CPIconType selectedIconType,
    super.key,
  }) : super(
          icon: CPIcon(type: iconType),
          selectedIcon: CPIcon(type: selectedIconType),
        );
}
