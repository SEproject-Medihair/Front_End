import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'legistrationscreen.dart';
import 'findpassword.dart';
import 'analysispage.dart';
import 'recordpage.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': _emailController.text,
        'password': _passwordController.text
      }),
    );
    if (!mounted) return;

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text('로그인에 성공하셨습니다'),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text('아이디와 비밀번호를 다시 확인해주세요.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/backimage.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: (EdgeInsets.only(top: 80)),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 34),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MEMBER',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Form(
                child: Theme(
                  data: ThemeData(
                    inputDecorationTheme: const InputDecorationTheme(
                      labelStyle:
                          TextStyle(color: Colors.black45, fontSize: 15.0),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40, 30, 40, 40),
                    child: Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            labelText: '이메일',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                        ),
                        TextField(
                            decoration:
                                const InputDecoration(labelText: '비밀번호'),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            controller: _passwordController),
                        const SizedBox(
                          height: 40.0,
                        ),
                        ButtonTheme(
                          minWidth: 100.0,
                          height: 50.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              minimumSize: const Size(290, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: _login,
                            child: const Text('Log in'),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Findpassword()),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black87,
                              ),
                              child: const Text('비밀번호 찾기'),
                            ),
                            const Text('|'),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegistrationScreen()));
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black87,
                              ),
                              child: const Text('회원가입'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Analysispage()),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.asset(
                                  'assets/images/Naverimage.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                              
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Recordpage()),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.asset(
                                  'assets/images/Kakaoimage.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.asset(
                                  'assets/images/Googleimage.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20),
                        ),
                        const Text(
                          '-L Garana-',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(175, 0, 0, 0),
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
      ),
    );
  }
}
