import 'package:casino_platform_test/src/app.dart';
import 'package:casino_platform_test/src/core/di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Entry point that initializes runtime dependencies before rendering UI.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await CPDI().init();
  runApp(const CPCasinoApp());
}
