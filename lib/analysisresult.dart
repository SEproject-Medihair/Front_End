import 'package:flutter/material.dart';
import 'package:hairapp/mainpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Analysisresult extends StatefulWidget {
  final String email;
  const Analysisresult({super.key, required this.email});

  @override
  _AnalysisresultState createState() => _AnalysisresultState(email: email);
}

class _AnalysisresultState extends State<Analysisresult> {
  String _response = '';
  String _responseTimeText = '';

  Future<void> _getResponse() async {
    final startTime = DateTime.now();
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer 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', // 여기에 실제 API 키 사용
      },
      body: jsonEncode(<String, dynamic>{
        'model': 'ft:gpt-3.5-turbo-0613:personal::8VZbqytb', // 모델 ID 포함
        'messages': [
          {
            'role': 'user',
            'content':
                '$name의 탈모상태는 $hairLossType이고 두피상태는 $scalpCondition. 메디헤어 일주일에 몇 번 사용하는지도 알려줘.'
          },
        ],
      }),
    );
    final endTime = DateTime.now(); // 요청 완료 시간
    final responseTime = endTime.difference(startTime);
    if (response.statusCode == 200) {
      var decodedBody = utf8.decode(response.bodyBytes); // UTF-8로 디코딩
      var data = json.decode(decodedBody);
      setState(() {
        _response = data['choices'][0]['message']['content'];
        _responseTimeText = 'Response time: ${responseTime.inMilliseconds}ms';
      });
    } else {
      setState(() {
        _response = 'Error: Failed to get response';
      });
    }
  }

  final String email;
  _AnalysisresultState({required this.email});
  String name = '';
  int hairDensity = 0;
  int hairThickness = 0;
  String hairLossType = '';
  String scalpCondition = '';
  int hairAge = 0;
  String date = '';

  @override
  void initState() {
    super.initState();
    _sendEmail();
  }

  Future<void> _sendEmail() async {
    final Uri url = Uri.parse('https://medihair.ngrok.io/api/Today_condition');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': widget.email}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        name = responseData['name'];
        var hairData = responseData['modifiedResult'];
        hairDensity = hairData['Hair_Density'];
        hairThickness = hairData['Hair_Thickness'];
        hairLossType = hairData['Hair_Loss_Type'];
        scalpCondition = hairData['Scalp_Condition'];
        hairAge = hairData['Hair_Age'];
        date = hairData['Date'];
      });
      _getResponse();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('오늘 모발 분석을 실시하지 않았습니다'),
        ),
      );
    }
  }

  String formatTextWithLineBreaks(String text, int chunkSize) {
    RegExp exp = RegExp('.{1,$chunkSize}');
    Iterable<Match> matches = exp.allMatches(text);
    return matches.map((m) => m.group(0)).join('\n');
  }

  @override
  Widget build(BuildContext context) {
    String formattedResponse = formatTextWithLineBreaks(_response, 25);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF9F2E7),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: (EdgeInsets.only(top: width * 0.1)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_rounded,
                        color: Color(0xFF51370E), size: 32),
                  ),
                  const SizedBox(
                    width: 90,
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '모발분석',
                    style: TextStyle(
                      color: Color(0xFF51370E),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                decoration: ShapeDecoration(
                  shadows: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // 그림자 색상 및 투명도
                      spreadRadius: 2, // 그림자의 퍼짐 정도
                      blurRadius: 5, // 그림자의 흐림 정도
                      offset: const Offset(1, 5), // 그림자의 위치 조정 (수평, 수직)
                    ),
                  ],
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                margin: const EdgeInsets.all(10),
                width: width,
                height: height * 0.34,
                padding: const EdgeInsets.only(top: 28),
                child: Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$name님의 모발 분석 결과",
                                style: const TextStyle(
                                    color: Color(0xFF51370E),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            children: [
                              const Text(
                                "탈모 상태: ",
                                style: TextStyle(
                                  color: Color(0xFF51370E),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              const Text(
                                "모발 밀도: ",
                                style: TextStyle(
                                  color: Color(0xFF51370E),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              const Text(
                                "모발 두께: ",
                                style: TextStyle(
                                  color: Color(0xFF51370E),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              const Text(
                                "두피 상태: ",
                                style: TextStyle(
                                  color: Color(0xFF51370E),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " $hairLossType",
                                style: const TextStyle(
                                  color: Color(0xFF51370E),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.033,
                              ),
                              Text(
                                " $hairDensity(1cm²당)",
                                style: const TextStyle(
                                  color: Color(0xFF51370E),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.033,
                              ),
                              Text(
                                " $hairThickness(µm)",
                                style: const TextStyle(
                                  color: Color(0xFF51370E),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.033,
                              ),
                              Text(
                                " $scalpCondition",
                                style: const TextStyle(
                                  color: Color(0xFF51370E),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 140,
                              ),
                              Text(
                                "Analyzed by",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "SookSook AI(Efficient B0)",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Response time: 5472 ms",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                decoration: ShapeDecoration(
                  shadows: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // 그림자 색상 및 투명도
                      spreadRadius: 2, // 그림자의 퍼짐 정도
                      blurRadius: 5, // 그림자의 흐림 정도
                      offset: const Offset(1, 5), // 그림자의 위치 조정 (수평, 수직)
                    ),
                  ],
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                margin: const EdgeInsets.all(10),
                width: width,
                height: height * 0.48,
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "AI 추천 솔루션:",
                          style: TextStyle(
                            color: Color(0xFF51370E),
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          formattedResponse,
                          style: const TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        SizedBox(
                          width: width * 0.82,
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "GPT-3.5-turbo",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "by fine-tuned model",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    _responseTimeText,
                                    softWrap: true,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: ShapeDecoration(
                  shadows: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // 그림자 색상 및 투명도
                      spreadRadius: 2, // 그림자의 퍼짐 정도
                      blurRadius: 5, // 그림자의 흐림 정도
                      offset: const Offset(1, 5), // 그림자의 위치 조정 (수평, 수직)
                    ),
                  ],
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                margin: const EdgeInsets.all(10),
                width: width,
                height: height * 0.3,
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AI 추천 케어:",
                          style: TextStyle(
                            color: Color(0xFF51370E),
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "LG - MEDI HAIR",
                          style: TextStyle(
                            color: Color(0xFF51370E),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "프론트케어 모드 | 18분",
                          style: TextStyle(
                            color: Color(0xFF51370E),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          "앞머리 뒷머리 집중 케어",
                          style: TextStyle(
                            color: Color(0xFF51370E),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 140,
                            height: 170,
                            child: Image.asset(
                              'assets/images/product.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF51370E)),
                        foregroundColor: const Color(0xFF51370E),
                        minimumSize: const Size(150, 50),
                        backgroundColor: const Color(0xFFFAE6C8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Mainpage(
                                    email: email,
                                  )),
                          (route) => false);
                    },
                    child: const Text(
                      '메인 페이지',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
