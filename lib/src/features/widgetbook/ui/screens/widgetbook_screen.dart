import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/main_shell/ui/screens/main_shell_screen.dart';
import 'package:casino_platform_test/src/features/widgetbook/ui/views/widgetbook_view.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:flutter/material.dart';

/// Widgetbook screen shell.
class CPWidgetbookScreen extends StatelessWidget {
  /// Route chunk for widgetbook screen.
  static const String pathChunk = 'widgetbook';

  /// Route path for widgetbook screen.
  static final CPRoutePath routePath = CPRoutePath(
    CPMainShellScreen.routePath.fullPath,
    <String>[pathChunk],
  );

  /// Creates [CPWidgetbookScreen].
  const CPWidgetbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.widgetbookTitle)),
      body: const CPWidgetbookView(),
    );
  }
}
