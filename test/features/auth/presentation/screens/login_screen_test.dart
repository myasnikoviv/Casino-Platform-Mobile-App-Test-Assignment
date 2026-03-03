import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fake_auth_service.dart';
import '../../../../helpers/test_app.dart';

void main() {
  group('CPLoginScreen', () {
    testWidgets('shows required field error on empty submit', (
      WidgetTester tester,
    ) async {
      final CPAuthCubit cubit = CPAuthCubit(CPFakeAuthService());

      await tester.pumpWidget(
        CPTestApp(
          home: BlocProvider<CPAuthCubit>.value(
            value: cubit,
            child: const CPLoginScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();

      expect(find.textContaining('This field is required.'), findsOneWidget);
      await cubit.close();
    });
  });
}
