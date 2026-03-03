import 'package:casino_platform_test/src/core/errors/guarded_executor.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fake_auth_service.dart';
import '../../../../helpers/test_app.dart';

void main() {
  group('CPSignUpScreen', () {
    testWidgets('shows mismatch error when passwords differ', (
      WidgetTester tester,
    ) async {
      final CPAuthCubit cubit =
          CPAuthCubit(CPFakeAuthService(), CPGuardedExecutor());

      await tester.pumpWidget(
        CPTestApp(
          home: BlocProvider<CPAuthCubit>.value(
            value: cubit,
            child: const CPSignUpScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextField).at(0),
        'Jane Tester',
      );
      await tester.enterText(
        find.byType(TextField).at(1),
        'jane@example.com',
      );
      await tester.enterText(
        find.byType(TextField).at(2),
        'Password123!',
      );
      await tester.enterText(
        find.byType(TextField).at(3),
        'Another123!',
      );

      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();

      expect(find.text('Passwords do not match.'), findsOneWidget);
      await cubit.close();
    });
  });
}
