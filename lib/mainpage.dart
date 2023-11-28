import 'package:flutter/material.dart';
import 'package:hairapp/recordpage.dart';
import 'settingpage.dart';
import 'analysispage.dart';
import 'chatpage.dart';
import 'noticepage.dart';
import 'profile.dart';
import 'package:url_launcher/url_launcher.dart';

class Mainpage extends StatefulWidget {
  final String email;

  const Mainpage({super.key, required this.email});

  @override
  State<Mainpage> createState() => _MainpageState(email: email);
}

class _MainpageState extends State<Mainpage> {
  final List<String> imagePaths = [
    'assets/images/hairloss_site1.png',
    'assets/images/hairloss_site2.png',
    'assets/images/hairloss_site3.png',
  ];

  final List<String> destinationUrls = [
    'https://daedamo.com/new/',
    'https://cafe.naver.com/gameguidel',
    'https://cafe.naver.com/imaban',
  ];

  DateTime? currentBackPressTime;
  final String email;
  _MainpageState({required this.email});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF9F2E7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              children: [
                const SizedBox(
                  height: 100,
                  width: 30,
                ),
                const Text(
                  "Welcome to SookSook",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      'assets/images/myphoto.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 330,
              height: 380,
              child: Stack(
                children: [
                  InkWell(
                    //--- 모발분석
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Analysispage(email: email)),
                      );
                    },
                    child: Positioned(
                      left: 0,
                      top: 0,
                      child: SizedBox(
                        width: 150,
                        height: 170,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: ShapeDecoration(
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // 그림자 색상 및 투명도
                                      spreadRadius: 2, // 그림자의 퍼짐 정도
                                      blurRadius: 5, // 그림자의 흐림 정도
                                      offset: const Offset(
                                          1, 5), // 그림자의 위치 조정 (수평, 수직)
                                    ),
                                  ],
                                  color: const Color(0xFFFFFDF9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              left: 52,
                              top: 155,
                              child: Text(
                                '모발분석',
                                style: TextStyle(
                                  color: Color(0xFF575757),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                  height: 0,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 26,
                              top: 24,
                              child: Container(
                                width: 98,
                                height: 102,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/analysis.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 180,
                    top: 0,
                    child: InkWell(
                      //--- 분석기록
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Recordpage(email: email)),
                        );
                      },
                      child: SizedBox(
                        width: 150,
                        height: 170,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: ShapeDecoration(
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // 그림자 색상 및 투명도
                                      spreadRadius: 2, // 그림자의 퍼짐 정도
                                      blurRadius: 5, // 그림자의 흐림 정도
                                      offset: const Offset(
                                          1, 5), // 그림자의 위치 조정 (수평, 수직)
                                    ),
                                  ],
                                  color: const Color(0xFFFFFDF9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              left: 52,
                              top: 155,
                              child: SizedBox(
                                width: 45,
                                height: 15,
                                child: Text(
                                  '분석기록',
                                  style: TextStyle(
                                    color: Color(0xFF575757),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w800,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 26,
                              top: 24,
                              child: Container(
                                width: 98,
                                height: 102,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/history.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 190,
                    child: InkWell(
                      //--- 추천제품
                      onTap: () {},
                      child: SizedBox(
                        width: 150,
                        height: 170,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: ShapeDecoration(
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // 그림자 색상 및 투명도
                                      spreadRadius: 2, // 그림자의 퍼짐 정도
                                      blurRadius: 5, // 그림자의 흐림 정도
                                      offset: const Offset(
                                          1, 5), // 그림자의 위치 조정 (수평, 수직)
                                    ),
                                  ],
                                  color: const Color(0xFFFFFDF9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              left: 52,
                              top: 155,
                              child: SizedBox(
                                width: 45,
                                height: 15,
                                child: Text(
                                  '추천제품',
                                  style: TextStyle(
                                    color: Color(0xFF575757),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w800,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 28,
                              top: 28,
                              child: Container(
                                width: 95,
                                height: 94.50,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/product_recommand.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 180,
                    top: 190,
                    child: InkWell(
                      //---챗봇
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatPage()),
                        );
                      },
                      child: SizedBox(
                        width: 150,
                        height: 170,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: ShapeDecoration(
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // 그림자 색상 및 투명도
                                      spreadRadius: 2, // 그림자의 퍼짐 정도
                                      blurRadius: 5, // 그림자의 흐림 정도
                                      offset: const Offset(
                                          1, 5), // 그림자의 위치 조정 (수평, 수직)
                                    ),
                                  ],
                                  color: const Color(0xFFFFFDF9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              left: 58,
                              top: 155,
                              child: SizedBox(
                                width: 34,
                                height: 15,
                                child: Text(
                                  '  챗봇',
                                  style: TextStyle(
                                    color: Color(0xFF575757),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w800,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 32,
                              top: 27,
                              child: Container(
                                width: 85.50,
                                height: 96,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/chatbot.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Container(
              width: 330,
              height: 185.62,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imagePaths.length,
                  itemBuilder: (context, index) {
                    if (index >= imagePaths.length) {
                      return null; // 인덱스가 범위를 벗어나면 더 이상 아이템을 렌더링하지 않음
                    }
                    return GestureDetector(
                      onTap: () async {
                        final url = destinationUrls[index];
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset(
                          imagePaths[index],
                          width: 300,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
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
                          Navigator.push(
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
                        onPressed: () {
                          Navigator.push(
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
                          Navigator.push(
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
