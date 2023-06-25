import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spotify_clone/constants/colors/colors.dart';
import 'package:spotify_clone/firebase_options.dart';
import 'package:spotify_clone/routes/routes.dart';
import 'package:spotify_clone/splash/splash_view.dart';
import 'package:spotify_clone/widgets/custom_filled_button.dart';
import 'package:spotify_clone/widgets/custom_outlined_button.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(),
      themeMode: ThemeMode.dark,
      initialRoute: Routes.splash,
      onGenerateRoute: Routes.generatedRoutes,
      theme: ThemeData(fontFamily: 'Gotham'),
    );
  }
}
