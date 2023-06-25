import 'package:flutter/material.dart';
import 'package:spotify_clone/authentication/register/register_view.dart';
import 'package:spotify_clone/routes/routes.dart';
import 'package:spotify_clone/widgets/custom_filled_button.dart';
import 'package:spotify_clone/widgets/custom_outlined_button.dart';

class BoardingView extends StatelessWidget {
  const BoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withOpacity(0.8), Colors.black],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 20,
              child: Column(
                children: [
                  CustomFilledButton(onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.home);
                    print("cdmvm");
                  }, text: "Sign up for free"),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomOutlinedButton(onPressed: () {
                    Navigator.pushNamed(context, Routes.login);
                  }, text: "Log in"),
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.3,
              child: const Column(
                children: [
                  Text(
                    "Millions of songs.",
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Free on Spotify.",
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.w500, color: Colors.white),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.55,
              child: Image.asset(
                "assets/images/spotify_logo.png",
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
