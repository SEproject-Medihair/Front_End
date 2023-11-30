import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'analysisresult.dart';

class Analysisloding extends StatefulWidget {
  final String email;
  final int one;
  final int two;
  const Analysisloding(
      {super.key, required this.email, required this.one, required this.two});

  @override
  State<Analysisloding> createState() =>
      _AnalysislodingState(email: email, one: one, two: two);
}

class _AnalysislodingState extends State<Analysisloding> {
  final String email;
  final int one;
  final int two;
  _AnalysislodingState(
      {required this.email, required this.one, required this.two});
  @override
  void initState() {
    super.initState();
    // 4초 타이머 설정
    Timer(const Duration(seconds: 4), () {
      // 서버에 데이터 전송
      sendHairAnalysis();
    });
  }

  Future<void> sendHairAnalysis() async {
    var url = Uri.parse('https://medihair.ngrok.io/api/Hair_Analyze');
    var response = await http.post(
      url,
      body: json.encode({'email': email, 'one': one, 'two': two}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // 서버 응답이 성공적일 때 페이지 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Analysisresult(email: email)),
      );
    } else {
      // 에러 처리
      print('Server error: ${response.statusCode}');
      // 필요한 경우 에러 페이지로 이동하거나 사용자에게 메시지 표시
    }
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
                padding: EdgeInsets.all(0.5),
                child: Center(),
              ),
            ),
          ),
        ),
        Positioned(
          top: height * 0.03,
          child: Image.asset(
            'assets/images/Analyzing.gif',
            width: width * 0.98,
            height: height * 0.98,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
