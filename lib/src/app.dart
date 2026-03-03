import 'package:casino_platform_test/src/core/di/di.dart';
import 'package:casino_platform_test/l10n/app_localizations.dart';
import 'package:casino_platform_test/src/core/router/app_router.dart';
import 'package:casino_platform_test/src/core/theme/app_theme.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Root app widget.
class CPCasinoApp extends StatefulWidget {
  /// Creates [CPCasinoApp].
  const CPCasinoApp({super.key});

  @override
  State<CPCasinoApp> createState() => _CPCasinoAppState();
}

class _CPCasinoAppState extends State<CPCasinoApp> {
  final CPDI _di = CPDI();
  CPAuthCubit? _authCubit;
  CPRouter? _router;

  @override
  void initState() {
    super.initState();
    _authCubit = CPAuthCubit(
      _di.resolve(),
      _di.resolve(),
    )..initialize();
    _router = CPRouter(_authCubit!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CPAuthCubit>(
      create: (_) => _authCubit!,
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Casino Platform',
            theme: CPAppTheme.lightTheme,
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const <Locale>[Locale('en')],
            routerConfig: _router!.router,
          );
        },
      ),
    );
  }
}
