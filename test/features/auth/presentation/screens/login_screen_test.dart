import 'package:casino_platform_test/src/core/errors/guarded_executor.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fake_auth_service.dart';
import '../../../../helpers/test_app.dart';

void main() {
  group('LoginScreen', () {
    testWidgets('shows required field error on empty submit', (
      WidgetTester tester,
    ) async {
      final AuthCubit cubit = AuthCubit(FakeAuthService(), GuardedExecutor());

      await tester.pumpWidget(
        TestApp(
          home: BlocProvider<AuthCubit>.value(
            value: cubit,
            child: const LoginScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();

      expect(find.text('This field is required.'), findsOneWidget);
      await cubit.close();
    });
  });
}
