import 'package:casino_platform_test/src/core/di/service_locator.dart';
import 'package:casino_platform_test/src/core/localization/app_localizations.dart';
import 'package:casino_platform_test/src/core/router/app_router.dart';
import 'package:casino_platform_test/src/core/theme/app_theme.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/games/presentation/cubit/games_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Root app widget that wires DI, router, theme and localization.
class CasinoApp extends StatefulWidget {
  /// Creates [CasinoApp].
  const CasinoApp({super.key});

  @override
  State<CasinoApp> createState() => _CasinoAppState();
}

class _CasinoAppState extends State<CasinoApp> {
  late final ServiceLocator _locator;
  late final Future<void> _bootstrap;
  AppRouter? _appRouter;

  @override
  void initState() {
    super.initState();
    _locator = ServiceLocator();
    _bootstrap = _initialize();
  }

  Future<void> _initialize() async {
    await _locator.initialize();
    _appRouter = AppRouter(_locator);
  }

  @override
  void dispose() {
    _locator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _bootstrap,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState != ConnectionState.done ||
            _appRouter == null) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return MultiBlocProvider(
          providers: <BlocProvider<dynamic>>[
            BlocProvider<AuthCubit>.value(value: _locator.authCubit),
            BlocProvider<GamesCubit>.value(value: _locator.gamesCubit),
          ],
          child: ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, __) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Casino Platform',
                theme: AppTheme.lightTheme,
                localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const <Locale>[Locale('en')],
                routerConfig: _appRouter!.router,
              );
            },
          ),
        );
      },
    );
  }
}
