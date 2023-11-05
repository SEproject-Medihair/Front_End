import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HairRecordPage extends StatelessWidget {
  final String email;

  HairRecordPage({required this.email});

  // 이메일 값을 서버에 전송하는 함수
  Future<void> _sendEmail(BuildContext context) async {
    final Uri url = Uri.parse('http://localhost:8080/api/Today_condition');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      // 성공적으로 데이터를 받아온 경우
      final data = jsonDecode(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HairDetailPage(
              //uName: data['U_name'],
              hairDensity: data['Hair_Density'],
              hairThickness: data['Hair_Thickness'],
              hairLossType: data['Hair_Loss_Type'],
              scalpCondition: data['Scalp_Condition'],
              hairAge: data['Hair_Age'],
              date: data['Date']),
        ),
      );
    } else {
      // 데이터를 받지 못한 경우
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('오늘 모발 분석을 실시하지 않았습니다'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('모발 기록'),
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
              child: Text('오늘의 기록'),
              onPressed: () {
                _sendEmail(context);
              },
            ),
            SizedBox(height: 20), // 간격 추가
            ElevatedButton(
              child: Text('날짜 선택'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DateSelectionPage(email: email),
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

class HairDetailPage extends StatelessWidget {
  //final String uName;
  final int hairDensity;
  final int hairThickness;
  final String hairLossType;
  final String scalpCondition;
  final int hairAge;
  final String date;

  HairDetailPage(
      { //required this.uName,
      required this.hairDensity,
      required this.hairThickness,
      required this.hairLossType,
      required this.scalpCondition,
      required this.hairAge,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$date의 모발 정보'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Text('이름: $uName'),
            // SizedBox(height: 20),
            Text('분석 날짜: $date'),
            SizedBox(height: 20),
            Text('모발 밀도: 1cm²당 $hairDensity개'),
            SizedBox(height: 20),
            Text('모발 두께: $hairThicknessμm(마이크로미터)'),
            SizedBox(height: 20),
            Text('탈모 유형: $hairLossType'),
            SizedBox(height: 20),
            Text('두피 상태: $scalpCondition'),
            SizedBox(height: 20),
            Text('모발 나이: $hairAge'),
          ],
        ),
      ),
    );
  }
}

class DateSelectionPage extends StatefulWidget {
  final String email;

  DateSelectionPage({required this.email});

  @override
  _DateSelectionPageState createState() => _DateSelectionPageState();
}

class _DateSelectionPageState extends State<DateSelectionPage> {
  late Future<List<String>> dates;

  @override
  void initState() {
    super.initState();
    dates = fetchDates();
  }

  Future<void> _fetchHairDetails(BuildContext context, String date) async {
    final Uri url = Uri.parse('http://localhost:8080/api/Choosen_date');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': widget.email, 'date': date}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HairDetailPage(
            //uName: data['U_name'],
            hairDensity: data['Hair_Density'],
            hairThickness: data['Hair_Thickness'],
            hairLossType: data['Hair_Loss_Type'],
            scalpCondition: data['Scalp_Condition'],
            hairAge: data['Hair_Age'],
            date: data['Date'],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('선택된 날짜에 대한 데이터를 불러오는 데 실패했습니다.'),
        ),
      );
    }
  }

  Future<List<String>> fetchDates() async {
    final Uri url = Uri.parse('http://localhost:8080/api/Choose_date');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': widget.email}),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((date) => date.toString()).toList();
    } else {
      throw Exception('Failed to load dates from the server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('날짜 선택'),
      ),
      body: FutureBuilder<List<String>>(
        future: dates,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('데이터를 불러오는 데 실패했습니다.'));
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]),
                  onTap: () {
                    _fetchHairDetails(context, snapshot.data![index]);
                  },
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
