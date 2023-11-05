import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TreatmentSolutionPage extends StatelessWidget {
  final String email;

  TreatmentSolutionPage({required this.email});

  Future<Map<String, dynamic>> fetchSolution() async {
    final Uri url = Uri.parse('http://localhost:8080/api/Solution');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load treatment solution');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('치료 솔루션'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchSolution(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('솔루션 정보를 불러오는 데 실패했습니다.'));
            }
            var sol;
            final data = snapshot.data!;
            if (data['Hair_Loss_Type'] == '탈모 아님') {
              sol =
                  "현재 탈모가 아닌 상태입니다. 주 1회 이상 꾸준히 메디헤어를 사용하시면 현재의 두피 상태를 유지할 수 있습니다.";
            } else {
              if (data['Scalp_Condition'] == '양호') {
                sol =
                    "${data['Hair_Loss_Type']}이며 양호한 상태입니다. 주3회 이상 메디헤어를 꾸준히 사용하시기 바랍니다.";
              } else if (data['Scalp_Condition'] == '최상') {
                sol =
                    "${data['Hair_Loss_Type']}이며 좋은 상태입니다. 주2회 이상 메디헤어를 꾸준히 사용하시기 바랍니다.";
              } else {
                sol =
                    "${data['Hair_Loss_Type']}이며 심각한 상태입니다. 주5회 이상 메디헤어를 꾸준히 사용하시기 바랍니다.";
              }
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(sol)
                  // // 데이터 예시입니다, 실제 데이터 키에 맞게 조정해주세요.
                  // Text('솔루션 이름: ${data['Solution_Name']}'),
                  // SizedBox(height: 20),
                  // Text('설명: ${data['Solution_Description']}'),
                  // SizedBox(height: 20),
                  // Text('적용 방법: ${data['Solution_Application']}'),
                  // SizedBox(height: 20),
                  // Text('기대 효과: ${data['Solution_Effect']}'),
                  // SizedBox(height: 20),
                  // Text('사용 기간: ${data['Solution_Duration']}'),
                  // SizedBox(height: 20),
                  // // 기타 필요한 정보를 여기에 추가하십시오.
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
