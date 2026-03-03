import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/profile/ui/screens/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fake_auth_service.dart';
import '../../../../helpers/test_app.dart';
import '../../../../helpers/test_session.dart';

void main() {
  group('CPProfileScreen', () {
    testWidgets('renders user data and dev widgetbook entry', (
      WidgetTester tester,
    ) async {
      final CPAuthCubit cubit = CPAuthCubit(
        CPFakeAuthService(loginResult: testSession),
      );
      await cubit.login('alex@example.com', 'Password123!');

      await tester.pumpWidget(
        CPTestApp(
          home: BlocProvider<CPAuthCubit>.value(
            value: cubit,
            child: const CPProfileScreen(),
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
