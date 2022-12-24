import 'package:flutter/material.dart';
import 'package:tictactoe/pages/multi_player_screen.dart';
import 'package:tictactoe/pages/single_player_screen.dart';
import 'package:tictactoe/pages/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const WelcomeScreen(),
        "/single-player": (context) => const SinglePlayerScreen(),
        "/multi-player": (context) => const MultiPlayerScreen()
      },
    );
  }
}
