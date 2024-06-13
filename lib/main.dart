import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'injectable.dart';
import 'presentation/application/application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);
  await configureDependencies();

  runApp(const Application());
}
