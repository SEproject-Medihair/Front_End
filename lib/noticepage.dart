import 'package:flutter/material.dart';
import 'settingpage.dart';
import 'mainpage.dart';
import 'package:intl/intl.dart';

//import 'profile.dart';
class AlarmInfo {
  DateTime dateTime;
  bool isActive;

  AlarmInfo({required this.dateTime, this.isActive = false});
}

class Noticepage extends StatefulWidget {
  const Noticepage({super.key});

  @override
  State<Noticepage> createState() => _NoticepageState();
}

class _NoticepageState extends State<Noticepage> {
  List<AlarmInfo> alarms = [];
  String email = '';

  void _addNewAlarm() async {
    // 날짜 선택기를 표시합니다.
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime day) {
        // 오늘 날짜 또는 이후 날짜만 선택 가능하도록 설정
        return day.isAfter(DateTime.now().subtract(const Duration(days: 1)));
      },
    );
    if (pickedDate != null) {
      // 시간 선택기를 표시합니다.
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        // 선택된 날짜와 시간으로 DateTime을 설정합니다.
        final DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        // 새 알람을 리스트에 추가합니다.
        setState(() {
          alarms.add(AlarmInfo(dateTime: finalDateTime));
        });
      }
    }
  }

  void _deleteAlarm(int index) {
    setState(() {
      alarms.removeAt(index);
    });
  }

  Widget _buildAlarmItem(AlarmInfo alarm, int index) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(DateFormat('EEEE(M/d)', 'ko_KR').format(alarm.dateTime),
                  style: const TextStyle(fontSize: 20)),
              Text(DateFormat('HH:mm').format(alarm.dateTime),
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          ),
          Switch(
            value: alarm.isActive,
            onChanged: (value) {
              setState(() {
                alarm.isActive = value;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteAlarm(index),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF9F2E7),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: alarms.length + 1,
              itemBuilder: (context, index) {
                if (index == alarms.length) {
                  // 마지막 인덱스에서 FloatingActionButton 반환
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(280, 10, 0, 0),
                    child: FloatingActionButton(
                      backgroundColor: const Color(0xFF51370E),
                      onPressed: _addNewAlarm,
                      child: const Icon(Icons.add),
                    ),
                  );
                } else {
                  // 기존 항목 반환
                  return _buildAlarmItem(alarms[index], index);
                }
              },
            ),
          ),
          Container(
            height: height * 0.09,
            width: width,
            color: const Color(0xFFFAE6C8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Settingpage()),
                        );
                      },
                      icon: const Icon(
                        Icons.settings,
                        size: 35,
                      ),
                    ),
                    const Text(
                      ' 설정',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Mainpage(email: email)),
                        );
                      },
                      icon: const Icon(
                        Icons.home_outlined,
                        size: 35,
                      ),
                    ),
                    const Text(
                      ' 홈',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                        size: 35,
                      ),
                    ),
                    const Text(
                      ' 알림',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Mainpage(email: email)),
                        );
                      },
                      icon: const Icon(
                        Icons.person,
                        size: 35,
                      ),
                    ),
                    const Text(
                      ' 마이',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
