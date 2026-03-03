import 'package:casino_platform_test/src/features/auth/ui/views/password_review_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('masks password text while keeping copy action available',
      (WidgetTester tester) async {
    const String rawPassword = 'MyStrong123!';
    var copyTapped = false;

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) {
          return MaterialApp(
            home: Scaffold(
              body: CPPasswordReviewView(
                title: 'Save your password',
                description: 'Copy and store it in a safe place.',
                password: rawPassword,
                copyLabel: 'Copy password',
                continueLabel: 'Continue',
                onCopyTap: () => copyTapped = true,
                onContinueTap: () {},
              ),
            ),
          );
        },
      ),
    );

    expect(find.text(rawPassword), findsNothing);
    final String maskedPassword = List<String>.filled(rawPassword.length, '*')
        .join();
    expect(find.text(maskedPassword), findsOneWidget);

    await tester.tap(find.text('Copy password'));
    await tester.pump();
    expect(copyTapped, isTrue);
  });
}
