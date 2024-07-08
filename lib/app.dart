import 'package:elea_mobile/presentation/app_colors.dart';
import 'package:elea_mobile/presentation/screens/home/view/home_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorBlack),
            iconTheme: const IconThemeData(color: AppColors.colorWhite)),
        home: const HomeScreen());
  }
}
