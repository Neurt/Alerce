import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alerce1/colour.dart';
import 'package:alerce1/layout/loginbox.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool showLoginBox = false;

  @override
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: mainPeach,
    body: ListView(
      children: [
        Center(
          child: AnimatedOpacity(
            opacity: showLoginBox ? 0.0 : 1.0,
            duration: const Duration(seconds: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animation/StartPageAnim.json'),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      showLoginBox = true;
                    });
                  },
                  child: Text(
                    "Let's Start",
                    style: GoogleFonts.openSans(),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showLoginBox)
          Center(
            child: LoginBox(),
          ),
      ],
    ),
  );
}
}
