import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/auth/ui/views/sign_up_view.dart';
import 'package:flutter/widgets.dart';

/// Registration screen shell.
class CPSignUpScreen extends StatelessWidget {
  /// Route chunk for sign-up screen.
  static const String pathChunk = 'sign-up';

  /// Route path for sign-up screen.
  static const CPRoutePath routePath = CPRoutePath(
    CPRoutePaths.authRoot,
    <String>[pathChunk],
  );

  /// Creates [CPSignUpScreen].
  const CPSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CPSignUpView();
  }
}
