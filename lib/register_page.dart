import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'login_page.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _verificationController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isVerificationButtonEnabled = true;
  bool isVerifyEnabled = false;
  bool isRegisterEnabled = false;
  String verificationButtonText = 'Send Verification Code';

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
            verificationButtonText = 'Send Verification Code';
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
        // And activate 'Send Verification Code' button
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

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LogIn()), // Assuming your login page class is named 'LogIn'
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _verificationController,
                    decoration:
                        const InputDecoration(labelText: 'Verification Code'),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: isVerificationButtonEnabled
                      ? () => _sendVerificationCode(_emailController.text)
                      : null,
                  child: Text(verificationButtonText),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: isVerifyEnabled
                      ? () => _verifyCode(
                          _emailController.text, _verificationController.text)
                      : null,
                  child: const Text('Verify'),
                ),
              ],
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isRegisterEnabled
                  ? () =>
                      _register(_emailController.text, _passwordController.text)
                  : null,
              child: const Text('Register'),
            ),
          ],
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
