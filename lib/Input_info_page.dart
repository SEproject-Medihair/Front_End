import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'main_page.dart';

class InputInfoPage extends StatefulWidget {
  final String email;
  InputInfoPage({required this.email});
  @override
  _InputInfoPageState createState() => _InputInfoPageState();
}

class _InputInfoPageState extends State<InputInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nicknameController =
      TextEditingController(); // 닉네임 컨트롤러 추가
  String? sex;

  Future<void> _sendData() async {
    final name = _nameController.text;
    final age = int.tryParse(_ageController.text);
    final nickname = _nicknameController.text; // 닉네임 가져오기

    // 이름, 나이 또는 닉네임이 비어 있으면 알림
    if (name.isEmpty || age == null || nickname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이름, 나이, 닉네임을 올바르게 입력해주세요.')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost:8080/api/submit_info'), // Your API Endpoint
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'age': age,
        'email': widget.email,
        'sex': sex,
        'nickname': nickname, // 서버로 닉네임 전송
      }),
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
              controller: _nicknameController,
              decoration: InputDecoration(labelText: '닉네임'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: '나이'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: sex,
              hint: Text("성별 선택"), // 선택 전 힌트 텍스트
              items: <String>['남', '녀'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  sex = newValue;
                });
              },
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
