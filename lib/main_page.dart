import 'hair_record_page.dart';
import 'Hair_Analyze.dart';
import 'chat_page.dart';
import 'Solution_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final String email;

  MyHomePage({required this.email});

  // // Function to handle the HTTP request and response
  // Future<void> fetchAndNavigate(BuildContext context) async {
  //   final Uri url = Uri.parse('http://localhost:8080/api/Get_Name');
  //   final response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'email': email}),
  //   );

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     final String name = data['name'].toString();
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Hair_Analyze(
  //           email: email,
  //           Name: name, // 확실히 'Name'이 반환되는 JSON의 키인지 확인하세요.
  //         ),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('사용자 이름을 불러오는 데 실패했습니다.'),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // UI remains unchanged
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Hair_Analyze(email: email),
                  ),
                );
              },
            ),
            SizedBox(height: 20), // Other buttons remain unchanged
            ElevatedButton(
              child: Text('모발 기록'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HairRecordPage(email: email),
                  ),
                );
              },
            ),
            SizedBox(height: 20), // 간격 추가
            ElevatedButton(
              child: Text('치료 솔루션'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TreatmentSolutionPage(email: email),
                  ),
                );
              },
            ),
            SizedBox(height: 20), // 간격 추가
            ElevatedButton(
              child: Text('리모컨'),
              onPressed: () {
                // TODO: 버튼 액션 처리
              },
            ),
            SizedBox(height: 20), // 간격 추가
            ElevatedButton(
              child: Text('채팅'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Chat(email: email),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
