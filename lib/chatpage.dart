import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = []; // 메시지와 메시지 타입(사용자 또는 챗봇)을 저장

  void addMessage(String message, String type, [DateTime? sentTime]) {
    setState(() {
      var responseTime = '';
      if (sentTime != null) {
        final duration = DateTime.now().difference(sentTime);
        responseTime = ' (응답 시간: ${duration.inSeconds}초)';
      }
      messages.add(
          {"type": type, "content": message, "responseTime": responseTime});
    });
  }

  Future<void> sendMessageToGPT(String message) async {
    final sentTime = DateTime.now();
    addMessage(message, "user"); // 메시지를 바로 추가

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'), // 변경된 엔드포인트
      headers: {
        'Authorization':
            'Bearer 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', // API 키
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'model': 'gpt-4', // GPT 4 최신모델 사용
        'messages': [
          {
            "role": "system",
            "content": "친절하고 귀엽고 자상한 고객 상담원, 대화끝에 항상 적절한 이모지를 붙인다."
          },
          {
            "role": "assistant",
            "content": "항상 탈모인의 입장을 이해하며 당신의 모발을 책임지는 쑥쑥이입니다, 무엇을 도와드릴까요?😊 "
          },
          {"role": "user", "content": "내가 두피 각질 상태가 많이 안좋은데 어떻게 관리할까?"},
          {
            "role": "assistant",
            "content":
                "모자 착용은 자외선 차단에 도움이 됩니다. 두피가 열을 받으면 붉고 예민해지면서 염증이 생기고 모낭 세포를 손상시켜 탈모를 일으키기 때문입니다.😢"
          },
          {"role": "user", "content": "머리를 감을 때 어떻게 감는게 좋아?"},
          {
            "role": "assistant",
            "content":
                "부드럽게 손톱 밑에 손가락을 이용해 마사지 하듯 두피를 감겨 주세요. 손톱을 이용하면 두피에 상처를 일으켜 탈모에 악영향을 끼칠 수 있어요😊"
          },
          {"role": "user", "content": message},
        ],
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      String reply =
          data['choices'][0]['message']['content'].trim(); // 변경된 응답 구조에 맞게 접근
      addMessage(reply, "bot", sentTime); // 챗봇의 응답을 추가
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load data: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI 쑥쑥에게 물어보세요!',
          style: TextStyle(
              color: Color(0xFF51370E),
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFFFAE6C8),
        foregroundColor: const Color(0xFF51370E),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final messageData = messages[index];
                return ListTile(
                  title: Align(
                    alignment: messageData['type'] == 'user'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: messageData['type'] == 'user'
                            ? const Color.fromARGB(255, 153, 195, 232)
                            : const Color(0xFFFAE6C8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: messageData['type'] == 'user'
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(messageData['content']),
                          Text(
                            messageData['responseTime'],
                            style: const TextStyle(
                                fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: '메시지를 입력하세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Color(0xFF51370E),
                  ),
                  onPressed: () {
                    final text = _controller.text;
                    _controller.clear();
                    if (text.isNotEmpty) {
                      sendMessageToGPT(text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
