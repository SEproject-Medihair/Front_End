import 'dart:async';
import 'loginpage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LogIn()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Positioned(
          top: 0.0,
          left: 0.0,
          child: SizedBox(
            width: width,
            height: height,
            child: const Scaffold(
              backgroundColor: Color(0xFFF9F2E7),
              body: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(),
              ),
            ),
          ),
        ),
        Positioned(
          top: height * 0.2,
          child: Image.asset(
            'assets/images/lodingman.gif',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
