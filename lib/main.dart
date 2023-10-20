import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
//import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hairapp',
      home: LogIn(),
    );
  }
}

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class MyHomePage extends StatelessWidget {
  final String email;
  MyHomePage({required this.email});
  //메뉴선택화면
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Buttons Demo'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('모발 분석'),
              onPressed: () {
                // TODO: 버튼 액션 처리
              },
            ),
            SizedBox(height: 20), // 간격 추가
            ElevatedButton(
              child: Text('모발 기록'),
              onPressed: () {
                // TODO: 버튼 액션 처리
              },
            ),
            SizedBox(height: 20), // 간격 추가
            ElevatedButton(
              child: Text('치료 솔루션'),
              onPressed: () {
                // TODO: 버튼 액션 처리
              },
            ),
            SizedBox(height: 20), // 간격 추가
            ElevatedButton(
              child: Text('리모컨'),
              onPressed: () {
                // TODO: 버튼 액션 처리
              },
            ),
          ],
        ),
      ),
    );
  }
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

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final userEmail = responseData['email'];

      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text('로그인에 성공하셨습니다'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(email: userEmail),
        ),
      );
    } else if (response.statusCode == 300) {
      final responseData = json.decode(response.body);
      final userEmail = responseData['email'];

      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text('로그인에 성공하셨습니다'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => InputInfoPage(email: userEmail),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text('비밀번호가 틀렸습니다.'),
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
                              onPressed: () {},
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
                              onTap: () {},
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
                              onTap: () {},
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

class InputInfoPage extends StatefulWidget {
  final String email;
  InputInfoPage({required this.email});
  @override
  _InputInfoPageState createState() => _InputInfoPageState();
}

class _InputInfoPageState extends State<InputInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  Future<void> _sendData() async {
    final name = _nameController.text;
    final age = int.tryParse(_ageController.text);

    if (name.isEmpty || age == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이름과 나이를 올바르게 입력해주세요.')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost:8080/api/submit_info'), // Your API Endpoint
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'age': age, 'email': widget.email}),
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(email: widget.email)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('데이터 전송에 실패했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('정보 입력')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '이름'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: '나이'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _sendData,
              child: Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}
