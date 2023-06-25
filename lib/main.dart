import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spotify_clone/firebase_options.dart';
import 'package:spotify_clone/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
