import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic tac toe"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 70,
              color: Colors.black,
              margin: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 0,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/single-player");
                },
                child: const Text(
                  "Single Player",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              width: 300,
              color: Colors.black,
              height: 70,
              margin: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 0,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/multi-player");
                },
                child: const Text(
                  "Multi Player",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              width: 300,
              color: Colors.black,
              height: 70,
              margin: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 0,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text(
                  "Exit",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
