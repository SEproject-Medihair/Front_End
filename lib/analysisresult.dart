import 'package:flutter/material.dart';

class Analysisresult extends StatefulWidget {
  const Analysisresult({super.key});

  @override
  State<Analysisresult> createState() => _AnalysisresultState();
}

class _AnalysisresultState extends State<Analysisresult> {
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
              Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "안효성님의",
                        style: TextStyle(
                            color: Color(0xFF51370E),
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "모발 분석 결과:",
                        style: TextStyle(
                            color: Color(0xFF51370E),
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width * 0.36,
                  ),
                  SizedBox(
                    width: width * 0.18,
                    child: Image.asset(
                      'assets/images/hairlossman.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
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
                      const Text(
                        " 전면 탈모",
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.033,
                      ),
                      const Text(
                        " 13(1cm²당)",
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.033,
                      ),
                      const Text(
                        " 45(µm)",
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.033,
                      ),
                      const Text(
                        " 심각",
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                width: width,
                height: height * 0.3,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "추천케어:",
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
                    Column(
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
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
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
                    onPressed: () {},
                    child: const Text(
                      '케어 진행 하기',
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
