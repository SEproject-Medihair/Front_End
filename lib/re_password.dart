import 'package:flutter/material.dart';
import 'package:hairapp/loginpage.dart';

class Repassword extends StatefulWidget {
  const Repassword({super.key});

  @override
  State<Repassword> createState() => _RepasswordState();
}

class _RepasswordState extends State<Repassword> {
  bool _obscureText = true;
  bool _obscureText_2 = true;
  bool _obscureText_3 = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleVisibility_2() {
    setState(() {
      _obscureText_2 = !_obscureText_2;
    });
  }

  void _toggleVisibility_3() {
    setState(() {
      _obscureText_3 = !_obscureText_3;
    });
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
              SizedBox(
                height: height * 0.1,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '비밀번호 변경',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40, height * 0.1, 40, 20),
                child: Column(children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: '현재 비밀번호',
                      suffixIcon: IconButton(
                        onPressed: _toggleVisibility,
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    obscureText: _obscureText,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: '새 비밀번호',
                      suffixIcon: IconButton(
                        onPressed: _toggleVisibility_2,
                        icon: Icon(
                          _obscureText_2
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    obscureText: _obscureText_2,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: '비밀번호 확인',
                      suffixIcon: IconButton(
                        onPressed: _toggleVisibility_3,
                        icon: Icon(
                          _obscureText_3
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    obscureText: _obscureText_3,
                  ),
                ]),
              ),
              SizedBox(
                height: height * 0.07,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(290, 40),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18))),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => const LogIn())));
                },
                child: const Text('변경 완료'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
