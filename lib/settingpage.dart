import 'package:flutter/material.dart';
import 'mainpage.dart';
import 'noticepage.dart';
import 'profile.dart';

class Settingpage extends StatefulWidget {
  const Settingpage({super.key});

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
  String email = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF9F2E7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: height * 0.19,
                child: const Stack(
                  children: [
                    Positioned(
                      left: 173,
                      top: 66,
                      child: Text(
                        '세팅',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              width: width,
              height: height * 0.72,
              child: Column(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: width,
                      height: height * 0.07,
                      color: const Color(0xFFFFFDF9),
                      child: Stack(
                        children: [
                          Positioned(
                            left: width * 0.1,
                            top: height * 0.023,
                            child: const Text(
                              'MY 메디헤얼',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: height * 0.02,
                  ),
                  Container(
                    width: width,
                    height: height * 0.07,
                    color: const Color(0xFFFFFDF9),
                    child: Stack(
                      children: [
                        Positioned(
                          left: width * 0.1,
                          top: height * 0.023,
                          child: const Text(
                            '메디헤어 가이드라인',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: height * 0.02,
                  ),
                  Container(
                    width: width,
                    height: height * 0.07,
                    color: const Color(0xFFFFFDF9),
                    child: Stack(
                      children: [
                        Positioned(
                          left: width * 0.1,
                          top: height * 0.023,
                          child: const Text(
                            '다크모드',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: height * 0.02,
                  ),
                  Container(
                    width: width,
                    height: height * 0.07,
                    color: const Color(0xFFFFFDF9),
                    child: Stack(
                      children: [
                        Positioned(
                          left: width * 0.1,
                          top: height * 0.023,
                          child: const Text(
                            '고객지원',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.09,
              width: width,
              color: const Color(0xFFFAE6C8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.settings,
                          size: 35,
                        ),
                      ),
                      const Text(
                        ' 설정',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Mainpage(email: email)),
                          );
                        },
                        icon: const Icon(
                          Icons.home_outlined,
                          size: 35,
                        ),
                      ),
                      const Text(
                        ' 홈',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Noticepage()),
                          );
                        },
                        icon: const Icon(
                          Icons.notifications,
                          size: 35,
                        ),
                      ),
                      const Text(
                        ' 알림',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profilepage()),
                          );
                        },
                        icon: const Icon(
                          Icons.person,
                          size: 35,
                        ),
                      ),
                      const Text(
                        ' 마이',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
