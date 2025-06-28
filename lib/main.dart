import 'package:alerce1/pages/start.dart';
import 'package:flutter/material.dart';

void main() {
  
  runApp(const AlerceApp());
}

class AlerceApp extends StatelessWidget {
  const AlerceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: StartPage(),
      //initialRoute: '/start',  
      //routes: {
        //'/start' :(context) => const StartPage(),
      //},
    );
  }
}