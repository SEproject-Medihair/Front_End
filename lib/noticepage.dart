import 'package:flutter/material.dart';
import 'settingpage.dart';
import 'mainpage.dart';

class Noticepage extends StatefulWidget {
  const Noticepage({super.key});

  @override
  State<Noticepage> createState() => _NoticepageState();
}

class _NoticepageState extends State<Noticepage> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF9F2E7),
      body: Column(
        children: [
          SizedBox(
              height: height * 0.17,
              child: Stack(
                children: [
                  Positioned(
                    left: width * 0.45,
                    top: height * 0.1,
                    child: const Text(
                      '알림',
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
            height: height * 0.737,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: width,
                    height: height * 0.1,
                    color: const Color(0xFFFFFDF9),
                    child: Stack(
                      children: [
                        Positioned(
                          left: width * 0.15,
                          top: height * 0.036,
                          child: Text(
                            _isSwitched ? '화요일' : '화요일',
                            style: TextStyle(
                              fontSize: 20,
                              color: _isSwitched
                                  ? const Color(0xFF000000)
                                  : const Color(0xFF9E9E9E),
                            ),
                          ),
                        ),
                        Positioned(
                          left: width * 0.35,
                          top: height * 0.028,
                          child: Text(
                            _isSwitched ? '21:00' : '21:00',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: _isSwitched
                                  ? const Color(0xFF000000)
                                  : const Color(0xFF9E9E9E),
                            ),
                          ),
                        ),
                        Positioned(
                          left: width * 0.7,
                          top: height * 0.03,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isSwitched = !_isSwitched;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 60.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: _isSwitched ? Colors.green : Colors.grey,
                              ),
                              child: Stack(children: [
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  top: 0.0,
                                  left: _isSwitched ? 30.0 : 0.0,
                                  right: _isSwitched ? 0.0 : 30.0,
                                  child: Container(
                                    width: 30.0,
                                    height: 30.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
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
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Settingpage()),
                        );
                      },
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
                              builder: (context) => const Mainpage()),
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
                      onPressed: () {},
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
                              builder: (context) => const Mainpage()),
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
    );
  }
}
