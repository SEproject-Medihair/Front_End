import 'package:flutter/material.dart';
import 'hair_record_page.dart';

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
