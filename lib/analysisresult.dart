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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('오늘 모발 분석을 실시하지 않았습니다'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                              "탈모 유형: ",
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
                              "탈모 상태: ",
                              style: TextStyle(
                                color: Color(0xFF51370E),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )
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
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
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
                height: height * 0.35,
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
                        SizedBox(
                          width: width * 0.8,
                          child: Row(
                            children: [
                              Flexible(
                                child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 7,
                                    text: const TextSpan(
                                      text:
                                          '세계문자 가운데 한글,즉 훈민정음은 흔히들 신비로운 문자라 부르곤 합니다. 그것은 세계 문자 가운데 유일하게 한글만이 그것을 만든 사람과 반포일을 알며, 글자를 만든 원리까지 알기 때문입니다. 세계에 이런 문자는 없습니다. 그래서 한글은, 정확히 말해 [훈민정음 해례본](국보 70호)은 진즉에 유네스코 세계기록유산으로 등재되었습니다. ‘한글’이라는 이름은 1910년대 초에 주시경 선생을 비롯한 한글학자들이 쓰기 시작한 것입니다. 여기서 ‘한’이란 크다는 것을 뜻하니, 한글은 ‘큰 글’을 말한다고 하겠습니다.[네이버 지식백과] 한글 - 세상에서 가장 신비한 문자 (위대한 문화유산, 최준식)',
                                      style: TextStyle(
                                        height: 1.4,
                                        color: Color(0xFF51370E),
                                        fontFamily: 'NanumDungGeunInYeon',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                      '메인으로',
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
