import 'package:flutter/material.dart';
import 'package:hairapp/graph.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Recordpage extends StatefulWidget {
  final String email; // 이메일을 받아오도록 추가

  const Recordpage({Key? key, required this.email}) : super(key: key);

  @override
  State<Recordpage> createState() => _RecordpageState();
}

class _RecordpageState extends State<Recordpage> {
  String name = '';
  int hairDensity = 0;
  int hairThickness = 0;
  String hairLossType = '';
  String scalpCondition = '';
  int hairAge = 0;
  String date = '';
  String? selectedFirstDate;
  String? selectedSecondDate;

  Future<void> _selectDate(BuildContext context, String buttonTag) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime day) {
        return dates.contains(DateFormat('yyyy-MM-dd').format(day));
      },
    );

    if (picked != null) {
      final selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        if (buttonTag == 'first') {
          selectedFirstDate = selectedDate;
          _fetchHairDetails(context, selectedDate);
        } else {
          selectedSecondDate = selectedDate;
          _fetchHairDetails2(context, selectedDate);
        }
      });
    }
  }

  Future<void> _sendEmail() async {
    final Uri url = Uri.parse('https://medihair.ngrok.io/api/Today_condition');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': widget.email}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);
      setState(() {
        name = responseData['name'];
        var hairData = responseData['modifiedResult'];
        hairDensity = hairData['Hair_Density'];
        hairThickness = hairData['Hair_Thickness'];
        hairLossType = hairData['Hair_Loss_Type'];
        scalpCondition = hairData['Scalp_Condition'];
        hairAge = hairData['Hair_Age'];
        date = hairData['Date'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('오늘 모발 분석을 실시하지 않았습니다'),
        ),
      );
    }
  }

  List<String> dates = []; // 날짜 목록을 저장할 리스트 추가
  bool clickdate = false;
  String clikedhairdensity = '';
  String clikedhairthickness = '';
  bool clickdate2 = false;
  String clikedhairdensity2 = '';
  String clikedhairthickness2 = '';
  // fetchDates 함수를 _fetchDates로 변경하고 initState에서 호출
  Future<void> _fetchDates() async {
    try {
      final Uri url = Uri.parse('https://medihair.ngrok.io/api/Choose_date');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': widget.email}),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<String> fetchedDates =
            data.map((date) => date.toString()).toList();
        setState(() {
          dates = fetchedDates; // 날짜 목록 업데이트
        });
      } else {
        throw Exception('Failed to load dates from the server');
      }
    } catch (e) {
      // 오류 처리
      print('Error fetching dates: $e');
    }
  }

  Future<List<int>> _fetchHairDetails(BuildContext context, String date) async {
    final Uri url = Uri.parse('https://medihair.ngrok.io/api/Record_choice');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': widget.email, 'date': date}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final hairData = responseData['modifiedResult'];

      print(hairData['Hair_Density']);
      print(hairData['Hair_Thickness']);
      if (hairData['Hair_Density'] is int &&
          hairData['Hair_Thickness'] is int) {
        setState(() {
          clickdate = true;
          clikedhairdensity = hairData['Hair_Density'].toString();
          clikedhairthickness = hairData['Hair_Thickness'].toString();
        });
        return [hairData['Hair_Density'], hairData['Hair_Thickness']];
      } else {
        // int로 변환할 수 없는 경우, 기본값이나 에러 처리를 하거나 원하는 작업을 수행합니다.
        return [0, 0]; // 예: 기본값으로 0을 반환
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('선택된 날짜에 대한 데이터를 불러오는 데 실패했습니다.'),
        ),
      );
      throw Exception('데이터를 불러오는 데 실패했습니다.');
    }
  }

  Future<List<int>> _fetchHairDetails2(
      BuildContext context, String date) async {
    final Uri url = Uri.parse('https://medihair.ngrok.io/api/Record_choice');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': widget.email, 'date': date}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final hairData = responseData['modifiedResult'];

      if (hairData['Hair_Density'] is int &&
          hairData['Hair_Thickness'] is int) {
        setState(() {
          clickdate2 = true;
          clikedhairdensity2 = hairData['Hair_Density'].toString();
          clikedhairthickness2 = hairData['Hair_Thickness'].toString();
        });
        return [hairData['Hair_Density'], hairData['Hair_Thickness']];
      } else {
        // int로 변환할 수 없는 경우, 기본값이나 에러 처리를 하거나 원하는 작업을 수행합니다.
        return [0, 0]; // 예: 기본값으로 0을 반환
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('선택된 날짜에 대한 데이터를 불러오는 데 실패했습니다.'),
        ),
      );
      throw Exception('데이터를 불러오는 데 실패했습니다.');
    }
  }

  @override
  void initState() {
    super.initState();
    _sendEmail();
    _fetchDates(); // 페이지가 초기화될 때 날짜를 가져옵니다.
  }

  bool istodayscreen = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF9F2E7),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: (EdgeInsets.only(top: width * 0.1)),
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
                    icon: const Icon(Icons.arrow_back_rounded,
                        color: Color(0xFF51370E), size: 32),
                  ),
                  const SizedBox(
                    width: 90,
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '모발기록',
                    style: TextStyle(
                      color: Color(0xFF51370E),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        istodayscreen = !istodayscreen;
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          bottomLeft: Radius.circular(4.0),
                        ),
                        color: istodayscreen
                            ? const Color(0xFF51370E)
                            : const Color(0xFFF9F2E7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '오늘',
                            style: TextStyle(
                                color: istodayscreen
                                    ? const Color(0xFFF9F2E7)
                                    : const Color(0xFF51370E),
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        istodayscreen = !istodayscreen;
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(4.0),
                          bottomRight: Radius.circular(4.0),
                        ),
                        color: !istodayscreen
                            ? const Color(0xFF51370E)
                            : const Color(0xFFF9F2E7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '비교',
                            style: TextStyle(
                                color: !istodayscreen
                                    ? const Color(0xFFF9F2E7)
                                    : const Color(0xFF51370E),
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: width * 0.95,
                decoration: ShapeDecoration(
                  shadows: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // 그림자 색상 및 투명도
                      spreadRadius: 2, // 그림자의 퍼짐 정도
                      blurRadius: 5, // 그림자의 흐림 정도
                      offset: const Offset(1, 5), // 그림자의 위치 조정 (수평, 수직)
                    ),
                  ],
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.02,
                    ),
                    SizedBox(
                      height: height * 0.18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$name님의 탈모유형:",
                            style: const TextStyle(
                                color: Color(0xFF51370E),
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFF9E4C2)),
                            child: Text(
                              ' $hairLossType ',
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF51370E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.2,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset('assets/images/hairlossman.png',
                              height: height * 0.23),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              if (!istodayscreen)
                Container(
                  width: width * 0.95,
                  decoration: ShapeDecoration(
                    shadows: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // 그림자 색상 및 투명도
                        spreadRadius: 2, // 그림자의 퍼짐 정도
                        blurRadius: 5, // 그림자의 흐림 정도
                        offset: const Offset(1, 5), // 그림자의 위치 조정 (수평, 수직)
                      ),
                    ],
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "비교할 날짜 선택",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xFF51370E),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 2),
                              ),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(149, 173, 180, 187),
                              ),
                              onPressed: () => _selectDate(context, 'first'),
                              child: Text(selectedFirstDate ?? '첫번째 날짜 선택'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_forward_sharp,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 2),
                              ),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(149, 173, 180, 187),
                              ),
                              onPressed: () => _selectDate(context, 'second'),
                              child: Text(selectedSecondDate ?? '두번째 날짜 선택'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            clickdate == true ? clikedhairdensity : "0",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 28,
                              color: Color(0xFF51370E),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.arrow_forward_sharp,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            clickdate2 == true ? clikedhairdensity2 : "0",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 28,
                              color: Color(0xFF51370E),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                            clickdate == true ? clikedhairthickness : "0",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 28,
                              color: Color(0xFF51370E),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.arrow_forward_sharp,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            clickdate2 == true ? clikedhairthickness2 : "0",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 28,
                              color: Color(0xFF51370E),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: '밀도',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Color(0xFF51370E),
                                  ),
                                ),
                                TextSpan(
                                  text: '(1cm²당)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    color: Color(0xFF51370E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: '두께',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Color(0xFF51370E),
                                  ),
                                ),
                                TextSpan(
                                  text: '(µm)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    color: Color(0xFF51370E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              if (!istodayscreen)
                const SizedBox(
                  height: 10,
                ),
              if (!istodayscreen)
                Container(
                  width: width * 0.95,
                  decoration: ShapeDecoration(
                    shadows: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // 그림자 색상 및 투명도
                        spreadRadius: 2, // 그림자의 퍼짐 정도
                        blurRadius: 5, // 그림자의 흐림 정도
                        offset: const Offset(1, 5), // 그림자의 위치 조정 (수평, 수직)
                      ),
                    ],
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "전체 치료 효과 데이터",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF51370E),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LineChartSample6(),
                  ]),
                ),
              if (istodayscreen)
                Container(
                  width: width * 0.95,
                  decoration: ShapeDecoration(
                    shadows: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // 그림자 색상 및 투명도
                        spreadRadius: 2, // 그림자의 퍼짐 정도
                        blurRadius: 5, // 그림자의 흐림 정도
                        offset: const Offset(1, 5), // 그림자의 위치 조정 (수평, 수직)
                      ),
                    ],
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "오늘: $date",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xFF51370E),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF9E4C2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "모발 밀도: ",
                                  style: TextStyle(
                                    color: Color(0xFF51370E),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  " $hairDensity(1cm²당)",
                                  style: const TextStyle(
                                    color: Color(0xFF51370E),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF9E4C2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "모발 두께: ",
                                  style: TextStyle(
                                    color: Color(0xFF51370E),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  " $hairThickness(µm)",
                                  style: const TextStyle(
                                    color: Color(0xFF51370E),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF9E4C2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "탈모 상태: ",
                                  style: TextStyle(
                                    color: Color(0xFF51370E),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  " $scalpCondition",
                                  style: const TextStyle(
                                    color: Color(0xFF51370E),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              const SizedBox(
                height: 12,
              ),
              if (istodayscreen)
                Container(
                  decoration: ShapeDecoration(
                    shadows: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // 그림자 색상 및 투명도
                        spreadRadius: 2, // 그림자의 퍼짐 정도
                        blurRadius: 5, // 그림자의 흐림 정도
                        offset: const Offset(1, 5), // 그림자의 위치 조정 (수평, 수직)
                      ),
                    ],
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  width: width * 0.95,
                  height: height * 0.27,
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "AI 추천 케어:",
                            style: TextStyle(
                              color: Color(0xFF51370E),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF9E4C2),
                            ),
                            child: const Text(
                              "프론트케어 모드 | 18분",
                              style: TextStyle(
                                color: Color(0xFF51370E),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text(
                            "앞머리 뒷머리 집중 케어",
                            style: TextStyle(
                              color: Color(0xFF51370E),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 120,
                              height: 150,
                              child: Image.asset(
                                'assets/images/product.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              if (istodayscreen)
                Container(
                  decoration: ShapeDecoration(
                    shadows: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // 그림자 색상 및 투명도
                        spreadRadius: 2, // 그림자의 퍼짐 정도
                        blurRadius: 5, // 그림자의 흐림 정도
                        offset: const Offset(1, 5), // 그림자의 위치 조정 (수평, 수직)
                      ),
                    ],
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  margin: const EdgeInsets.all(10),
                  width: width,
                  height: height * 0.35,
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "AI 추천 솔루션:",
                            style: TextStyle(
                              color: Color(0xFF51370E),
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: width * 0.8,
                            child: Row(
                              children: [
                                Flexible(
                                  child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 7,
                                      text: const TextSpan(
                                        text:
                                            '진우님의 모발 분석 결과 경증 탈모로 모발의 밀도가 낮으나 부분적으로 두께가 굵은 모발이 있는 상황입니다. 두피상태는 양호로 두피표면에 색상이 균일하며 각질이나 불순물이 확인되지 않습니다. 종합적으로 보았을 때 일주일에 3번 하루 30분동안 메디헤어 프론트모드를 사용하시는 것을 추천합니다.',
                                        style: TextStyle(
                                          height: 1.4,
                                          color: Color(0xFF51370E),
                                          fontFamily: 'NanumDungGeunInYeon',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
