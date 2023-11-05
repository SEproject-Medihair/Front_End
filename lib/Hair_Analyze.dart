import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for using json.decode

class Hair_Analyze extends StatelessWidget {
  final String email;
  //final String Name;

  Hair_Analyze({required this.email}); //, required this.Name});

  Future<void> analyzeHair(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/Hair_Analyze'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        //'Name': Name,
      }),
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      var data = json.decode(response.body);

      // Navigate to the detail page and pass the data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HairDetailPage(data: data),
        ),
      );
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load analysis');
    }
  }

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
              onPressed: () => analyzeHair(context),
            ),
          ],
        ),
      ),
    );
  }
}

class HairDetailPage extends StatelessWidget {
  final dynamic data;

  HairDetailPage({required this.data});

  @override
  Widget build(BuildContext context) {
    // Here you will build the UI to display the data.
    // I'll provide a basic example:

    return Scaffold(
      appBar: AppBar(
        title: Text('Hair Analysis Result'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('분석 날짜: ${data['Date']}'),
            Text('모발 밀도: 1cm²당 ${data['Hair_Density']}개'),
            Text('모발 두께: ${data['Hair_Thickness']}μm(마이크로미터)'),
            Text('탈모 유형: ${data['Hair_Loss_Type']}'),
            Text('두피 상태: ${data['Scalp_Condition']}'),
            // Add more widgets for each piece of data as needed
          ],
        ),
      ),
    );
  }
}
