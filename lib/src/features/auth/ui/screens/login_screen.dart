import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/auth/ui/views/login_view.dart';
import 'package:flutter/widgets.dart';

/// Login screen shell.
class CPLoginScreen extends StatelessWidget {
  /// Route chunk for login screen.
  static const String pathChunk = 'login';

  /// Route path for login screen.
  static const CPRoutePath routePath = CPRoutePath(
    CPRoutePaths.authRoot,
    <String>[pathChunk],
  );

  /// Creates [CPLoginScreen].
  const CPLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CPLoginView();
  }
}
