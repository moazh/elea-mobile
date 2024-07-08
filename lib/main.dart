import 'package:elea_mobile/app.dart';
import 'package:elea_mobile/injector.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const App());
}
