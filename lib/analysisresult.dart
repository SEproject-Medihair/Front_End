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

  Future<String> textchoose() async {
    String solutiontext = '';
    if (hairLossType == '탈모 아님') {
      solutiontext = '진우님의 모발 분석 결과 탈모가 아니며 모발의 밀도와 굵기 모두 정상입니다.';
    } else if (hairLossType == '경증 탈모') {
      solutiontext =
          '진우님의 모발 분석 결과 경증 탈모로 모발의 밀도가 낮으나 부분적으로 두께가 굵은 모발이 있는 상황입니다.';
    } else if (hairLossType == '중경증 탈모') {
      solutiontext = '진우님의 모발 분석 결과 중경증 탈모로 모발의 밀도가 낮고 두께가 낮은 상황입니다.';
    } else if (hairLossType == '중증 탈모') {
      solutiontext =
          '진우님의 모발 분석 결과 중증 탈모로 모발의 밀도가 낮고 모발 두께도 전체적으로 매우 얇은 상황입니다. 두피 진단 시 빈 모공이 2개 이상 관찰됩니다.';
    } else {
      solutiontext = '정확한 진단을 위해 다시 한번 검사를 실시하여 주세요.';
    }
    return solutiontext;
  }

  Future<String> textchoose2() async {
    String solutiontext2 = '';
    if (scalpCondition == '안전') {
      solutiontext2 = '두피상태는 안전으로 두피 표면의 색상이 균일하며 각질이나 불순물이 확인되지 않습니다.';
    } else if (scalpCondition == '양호') {
      solutiontext2 = '두피상태는 양호로 홍반이나 피지 과다가 없으나, 작고 가루 같은 각질이 관찰됩니다.';
    } else if (scalpCondition == '위험') {
      solutiontext2 = '두피상태는 위험으로 작고 가루같은 각질이 종종 보이며, 두피에 갈라진 표면이 보입니다.';
    } else if (scalpCondition == '심각') {
      solutiontext2 =
          '두피상태는 심각으로 작고 가루같은 각질이 많이 보이며, 두피 모공 주위에 나이테 모양의 표면이 보입니다.';
    } else {
      solutiontext2 = '정확한 진단을 위해 다시 한번 검사를 실시하여 주세요.';
    }
    return solutiontext2;
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
                    Expanded(
                      child: Column(
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
                            child: Column(
                              children: [
                                FutureBuilder<String>(
                                  future:
                                      textchoose(), // 여기에 Future<String> 함수를 넣습니다.
                                  builder: (context, snapshot) {
                                    // 연결 상태에 따라 다르게 처리
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator(); // 데이터를 기다리는 동안 로딩 표시
                                    } else if (snapshot.hasError) {
                                      return Text(
                                          "Error: ${snapshot.error}"); // 에러 발생 시 표시
                                    } else {
                                      // 데이터가 성공적으로 반환되었을 때
                                      return Text(
                                        snapshot.data ?? "데이터 없음",
                                        style: const TextStyle(fontSize: 17),
                                      );
                                    }
                                  },
                                ),
                                FutureBuilder<String>(
                                  future:
                                      textchoose2(), // 여기에 Future<String> 함수를 넣습니다.
                                  builder: (context, snapshot) {
                                    // 연결 상태에 따라 다르게 처리
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator(); // 데이터를 기다리는 동안 로딩 표시
                                    } else if (snapshot.hasError) {
                                      return Text(
                                          "Error: ${snapshot.error}"); // 에러 발생 시 표시
                                    } else {
                                      // 데이터가 성공적으로 반환되었을 때
                                      return Text(
                                        snapshot.data ?? "데이터 없음",
                                        style: const TextStyle(fontSize: 17),
                                      );
                                    }
                                  },
                                ),
                                const Text('')
                              ],
                            ),
                          ),
                        ],
                      ),
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
