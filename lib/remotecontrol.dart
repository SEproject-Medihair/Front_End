import 'package:flutter/material.dart';
import 'profile.dart';
import 'surveypage.dart';
import 'settingpage.dart';
import 'mainpage.dart';
import 'noticepage.dart';
import 'camera.dart';

class Remotecontrol extends StatefulWidget {
  const Remotecontrol({super.key});

  @override
  State<Remotecontrol> createState() => _RemotecontrolState();
}

class _RemotecontrolState extends State<Remotecontrol> {
  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(
                    width: 90,
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '리모컨',
                    style: TextStyle(
                      color: Color(0xFF51370E),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.07,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '프론트케어',
                    style: TextStyle(
                      color: Color(0xFF51370E),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              SizedBox(
                width: 220,
                height: 240,
                child: Image.asset(
                  'assets/images/product.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '연결중 ',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(202, 85, 83, 79),
                    ),
                  ),
                  Text(
                    'MEDI HAIR-HGN1',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF51370E),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFF51370E),
                        minimumSize: const Size(30, 40),
                        backgroundColor: const Color(0xFFFAE6C8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profilepage()),
                      );
                    },
                    child: const Icon(
                      Icons.pause,
                      size: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFF51370E),
                        minimumSize: const Size(30, 40),
                        backgroundColor: const Color(0xFFFAE6C8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Surveypage()),
                      );
                    },
                    child: const Icon(
                      Icons.power_settings_new,
                      size: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFF51370E),
                        minimumSize: const Size(30, 40),
                        backgroundColor: const Color(0xFFFAE6C8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Settingpage()),
                      );
                    },
                    child: const Icon(
                      Icons.play_arrow,
                      size: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFF51370E),
                        minimumSize: const Size(125, 40),
                        backgroundColor: const Color(0xFFFAE6C8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Mainpage()),
                      );
                    },
                    child: const Text(
                      '토탈케어 모드',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 35,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFF51370E),
                        minimumSize: const Size(125, 40),
                        backgroundColor: const Color(0xFFFAE6C8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Noticepage()),
                      );
                    },
                    child: const Text(
                      '프론트케어 모드',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFF51370E),
                        minimumSize: const Size(125, 40),
                        backgroundColor: const Color(0xFFFAE6C8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Camera()),
                      );
                    },
                    child: const Text(
                      '탑케어 모드',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 35,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFF51370E),
                        minimumSize: const Size(125, 40),
                        backgroundColor: const Color(0xFFFAE6C8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: const Text(
                      'MY 케어 모드',
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
