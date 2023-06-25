import 'package:flutter/material.dart';
import 'package:spotify_clone/widgets/custom_filled_button.dart';
import 'package:spotify_clone/widgets/custom_outlined_button.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign up for free",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                  const SizedBox(height: 20,),
                  CustomFilledButton(onPressed: () {}, text: "Continue with email", icon: Icons.mail_outline_outlined),
                  const SizedBox(height: 10,),
                  CustomOutlinedButton(onPressed: () {}, text: "Continue with phone number",icon: Icons.phone_android),
                  const SizedBox(height: 10,),
                  CustomOutlinedButton(onPressed: () {}, text: "Continue with Google",icon: Icons.g_mobiledata),
                ],
              ),
            ),
            Positioned(
              top: 15,
              left: 10,
              child: BackButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
