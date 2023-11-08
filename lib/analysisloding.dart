import 'package:flutter/material.dart';
import 'dart:async';
import 'analysisresult.dart';

class Analysisloding extends StatefulWidget {
  const Analysisloding({super.key});

  @override
  State<Analysisloding> createState() => _AnalysislodingState();
}

class _AnalysislodingState extends State<Analysisloding> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Analysisresult()),
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
              backgroundColor: Colors.black87,
              body: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(),
              ),
            ),
          ),
        ),
        Positioned(
          top: height * 0.2,
          left: width * 0.1,
          child: Image.asset(
            'assets/images/product.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
