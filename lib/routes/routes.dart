import 'package:flutter/material.dart';
import 'package:spotify_clone/authentication/login/login_view.dart';
import 'package:spotify_clone/authentication/register/register_view.dart';
import 'package:spotify_clone/boarding/boarding_view.dart';
import 'package:spotify_clone/main/detail/detail_view.dart';
import 'package:spotify_clone/main/home/home_view.dart';
import 'package:spotify_clone/main/main_view.dart';
import 'package:spotify_clone/main/player/player_view.dart';
import 'package:spotify_clone/modal/audio_modal.dart';
import 'package:spotify_clone/splash/splash_view.dart';

class Routes {
  static const splash = "/";
  static const boarding = "/boarding";
  static const register = "/register";
  static const login = "/login";
  static const home = "/main";
  static const detail = "/detail";
  static const player = "/player";

  static Route<dynamic> generatedRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case Routes.boarding:
        return MaterialPageRoute(builder: (context) => const BoardingView());
      case Routes.register:
        return MaterialPageRoute(builder: (context) => const RegisterView());
      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const HomeView());
      case Routes.detail:
        var data= routeSettings.arguments as AudioModal;
        return MaterialPageRoute(builder: (context) =>  DetailView(data: data));
      case Routes.player:
        var data= routeSettings.arguments as Map<String,dynamic>;
        print(data['songList']);
        return MaterialPageRoute(builder: (context) =>  PlayerView(poster:  data['poster'],songList: data['songList'],passedIndex: data['index'],));
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('ERROR'),
          ),
        );
      },
    );
  }
}
