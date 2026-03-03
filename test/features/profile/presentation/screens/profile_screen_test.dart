import 'package:casino_platform_test/src/core/errors/guarded_executor.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fake_auth_service.dart';
import '../../../../helpers/test_app.dart';
import '../../../../helpers/test_session.dart';

void main() {
  group('ProfileScreen', () {
    testWidgets('renders user data and dev widgetbook entry', (
      WidgetTester tester,
    ) async {
      final AuthCubit cubit = AuthCubit(
        FakeAuthService(loginResult: testSession),
        GuardedExecutor(),
      );
      await cubit.login('alex@example.com', 'Password123!');

      await tester.pumpWidget(
        TestApp(
          home: BlocProvider<AuthCubit>.value(
            value: cubit,
            child: const ProfileScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Alex Palmer'), findsOneWidget);
      expect(find.text('alex@example.com'), findsOneWidget);
      expect(find.text('Open Widgetbook'), findsOneWidget);
      await cubit.close();
    });
  });
}
