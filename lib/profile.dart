import 'package:flutter/material.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  String email = '';
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
                padding: (EdgeInsets.only(top: height * 0.1)),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '프로필',
                    style: TextStyle(
                      color: Color(0xFF51370E),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 0.07,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ID: ",
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "나이: ",
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "성별: ",
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "탈모유형: ",
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " 안효성",
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        " 25",
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        " 남",
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " 전면탈모",
                        style: TextStyle(
                          color: Color(0xFF51370E),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: width * 0.15,
                  ),
                  Column(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/myphoto.png',
                          fit: BoxFit.cover,
                          width: width * 0.3,
                          height: height * 0.17,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 72,
              ),
              Container(
                width: width,
                height: height * 0.1,
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                color: Colors.white,
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "맴버 관리",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: width,
                height: height * 0.1,
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                color: Colors.white,
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "로그아웃",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 195,
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
                          onPressed: () {},
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
                          onPressed: () {},
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
      ),
    );
  }
}
