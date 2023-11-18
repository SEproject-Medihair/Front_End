import 'package:flutter/material.dart';
import 'analysisloding.dart';
import 'remotecontrol.dart';

class Analysispage extends StatefulWidget {
  const Analysispage({super.key});

  @override
  State<Analysispage> createState() => _AnalysispageState();
}

class _AnalysispageState extends State<Analysispage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                padding: (EdgeInsets.only(top: height * 0.05)),
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
                  SizedBox(
                    width: width * 0.25,
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
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '연결중 ',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(202, 85, 83, 79),
                    ),
                  ),
                  Text(
                    'MEDI HAIR-HGN1',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF51370E),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.13,
              ),
              SizedBox(
                width: 270,
                height: 270,
                child: Stack(
                  children: [
                    Positioned(
                      left: -10,
                      top: -5,
                      child: Container(
                        width: 290,
                        height: 290,
                        decoration: const ShapeDecoration(
                          color: Color(0x26FDD596),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 5,
                      top: 10,
                      child: Opacity(
                        opacity: 0.30,
                        child: Container(
                          width: 260,
                          height: 260,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFFCD495),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 20,
                      child: Container(
                        width: 230,
                        height: 230,
                        decoration: const ShapeDecoration(
                          color: Color(0x99FDD596),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 35,
                      top: 35,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFFCD495),
                          shape: OvalBorder(
                            side:
                                BorderSide(width: 2, color: Color(0xFFFCCD85)),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 84,
                      top: 77,
                      child: Text(
                        '지난번 분석 점수',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w900,
                          height: 0,
                          letterSpacing: -0.30,
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 89,
                      top: 106,
                      child: Text(
                        '87',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 80,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w900,
                          height: 0,
                          letterSpacing: -0.30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF51370E)),
                        foregroundColor: const Color(0xFF51370E),
                        minimumSize: const Size(120, 40),
                        backgroundColor: const Color(0xFFFAE6C8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Analysisloding(),
                        ),
                      );
                    },
                    child: const Text(
                      '분석 시작',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF51370E)),
                      foregroundColor: const Color(0xFF51370E),
                      minimumSize: const Size(40, 40),
                      backgroundColor: const Color(0xFFFAE6C8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Remotecontrol(),
                        ),
                      );
                    },
                    child: const Icon(Icons.replay_rounded),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "지난번 분석: 10.06",
                style: TextStyle(
                  color: Color.fromARGB(255, 118, 115, 104),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "12",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF51370E),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "43",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF51370E),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "심각",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF51370E),
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "밀도(1cm²당)",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF51370E),
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Text(
                    "두께(µm)",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF51370E),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "탈모상태",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF51370E),
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
