import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _verificationController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isVerificationButtonEnabled = true;
  bool isVerifyEnabled = false;
  bool isRegisterEnabled = false;
  String verificationButtonText = '인증코드발송';

  Timer? _timer;
  int _start = 3 * 60; // 3 minutes in seconds

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            isVerificationButtonEnabled = true;
            verificationButtonText = '인증코드발송';
          });
        } else {
          setState(() {
            _start--;
            verificationButtonText = 'Resend in ${_start ~/ 60}:${_start % 60}';
          });
        }
      },
    );
  }

  Future<void> _sendVerificationCode(String email) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/send_verification'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      if (responseBody['error'] == 'email_exists') {
        // Show '해당 이메일은 이미 가입되어 있습니다' message to the user
        // And activate '인증 코드 발송' button
      } else {
        setState(() {
          isVerifyEnabled = true;
          isVerificationButtonEnabled = false;
          _start = 3 * 60;
          startTimer();
        });
      }
    } else {
      var responseBody = json.decode(response.body);
      if (!mounted) return;
      _showDialog(context, responseBody['message']);
    }
  }

  Future<void> _verifyCode(String email, String code) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/verify_code'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'code': code}),
    );

    if (response.statusCode == 200) {
      bool isVerified = json.decode(response.body)['isVerified'];
      if (isVerified) {
        setState(() {
          isRegisterEnabled = true;
          isVerifyEnabled = false;
        });
      } else {
        // Show '인증번호가 틀렸습니다' message to the user and activate the 'Verify' button
      }
    } else {
      var responseBody = json.decode(response.body);
      if (!mounted) return;
      _showDialog(context, responseBody['message']);
    }
  }

  Future<void> _register(String email, String password) async {
    String confirmPassword = _confirmPasswordController.text;

    // 1. Check if both passwords match
    if (password != confirmPassword) {
      _showDialog(context, '입력하신 비밀번호가 서로 다릅니다.');
      return;
    }

    // 2. Check if password length is more than 10 characters
    if (password.length < 10) {
      _showDialog(context, '비밀번호는 10자리 이상이어야합니다.');
      return;
    }

    // 3. Check if password contains only alphanumeric and special characters
    if (!RegExp(r'^[a-zA-Z0-9!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]+$')
        .hasMatch(password)) {
      _showDialog(context, '비밀번호는 숫자, 알파벳, 특수문자로만 구성될 수 있습니다.');
      return;
    }

    // 4. Check if password contains at least one alphabet and one number
    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(password)) {
      _showDialog(context, '비밀번호는 숫자와 알파벳이 필수로 포함하여야 합니다.');
      return;
    }
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    if (!mounted) return;
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WebView(
            initialUrl: 'https://www.google.com',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      );
    } else {
      var responseBody = json.decode(response.body);
      _showDialog(context, responseBody['message']);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

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
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.black87, size: 32),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CREATE',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'ACCOUNT',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40, height * 0.1, 40, 20),
                child: Column(children: [
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: '이메일'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _verificationController,
                          decoration: const InputDecoration(labelText: '인증코드'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18))),
                        onPressed: isVerificationButtonEnabled
                            ? () => _sendVerificationCode(_emailController.text)
                            : null,
                        child: Text(verificationButtonText),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18))),
                        onPressed: isVerifyEnabled
                            ? () => _verifyCode(_emailController.text,
                                _verificationController.text)
                            : null,
                        child: const Text('인증'),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: '비밀번호'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(labelText: '비밀번호 확인'),
                    obscureText: true,
                  ),
                ]),
              ),
              SizedBox(
                height: height * 0.12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(290, 40),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18))),
                onPressed: isRegisterEnabled
                    ? () => _register(
                        _emailController.text, _passwordController.text)
                    : null,
                child: const Text('Sign up'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
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

void _showDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("알림"),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
