import 'package:flutter/material.dart';

class Recordpage extends StatefulWidget {
  const Recordpage({Key? key}) : super(key: key);

  @override
  State<Recordpage> createState() => _RecordpageState();
}

class _RecordpageState extends State<Recordpage> {
  bool istodayscreen = true;
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
              const Padding(
                padding: (EdgeInsets.only(top: 30)),
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
                  const Text(
                    '모발기록',
                    style: TextStyle(
                      color: Color(0xFF51370E),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        istodayscreen = !istodayscreen;
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 25,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          bottomLeft: Radius.circular(4.0),
                        ),
                        color: istodayscreen
                            ? const Color(0xFF51370E)
                            : const Color(0xFFF9F2E7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '오늘',
                            style: TextStyle(
                                color: istodayscreen
                                    ? const Color(0xFFF9F2E7)
                                    : const Color(0xFF51370E),
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        istodayscreen = !istodayscreen;
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 25,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(4.0),
                          bottomRight: Radius.circular(4.0),
                        ),
                        color: !istodayscreen
                            ? const Color(0xFF51370E)
                            : const Color(0xFFF9F2E7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '비교',
                            style: TextStyle(
                                color: !istodayscreen
                                    ? const Color(0xFFF9F2E7)
                                    : const Color(0xFF51370E),
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.02,
                    ),
                    SizedBox(
                      height: height * 0.18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "OO님의 탈모유형:",
                            style: TextStyle(
                                color: Color(0xFF51370E),
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFF9E4C2)),
                            child: const Text(
                              ' 전면 탈모 ',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF51370E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.25,
                    ),
                    Column(
                      children: [
                        Image.asset('assets/images/hairlossman.png',
                            height: height * 0.23),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              if (!istodayscreen)
                Container(
                  width: width * 0.95,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "비교할 날짜 선택",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xFF51370E),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (istodayscreen)
                Container(
                  width: width * 0.95,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "오늘: 2023.12.06",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xFF51370E),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF9E4C2),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "모발 밀도: ",
                                  style: TextStyle(
                                    color: Color(0xFF51370E),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  " 13(1cm²당)",
                                  style: TextStyle(
                                    color: Color(0xFF51370E),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF9E4C2),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "모발 두께: ",
                                  style: TextStyle(
                                    color: Color(0xFF51370E),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  " 45(µm)",
                                  style: TextStyle(
                                    color: Color(0xFF51370E),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF9E4C2),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "탈모 상태: ",
                                  style: TextStyle(
                                    color: Color(0xFF51370E),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  " 심각",
                                  style: TextStyle(
                                    color: Color(0xFF51370E),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              if (istodayscreen)
                Container(
                  width: width,
                  height: height * 0.3,
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "추천케어:",
                            style: TextStyle(
                              color: Color(0xFF51370E),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF9E4C2),
                            ),
                            child: const Text(
                              "프론트케어 모드 | 18분",
                              style: TextStyle(
                                color: Color(0xFF51370E),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text(
                            "앞머리 뒷머리 집중 케어",
                            style: TextStyle(
                              color: Color(0xFF51370E),
                              fontSize: 15,
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
                            width: 100,
                            height: 120,
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
            ],
          ),
        ),
      ),
    );
  }
}
