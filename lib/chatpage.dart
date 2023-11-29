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
  List<String> messages = [];

  Future<void> sendMessageToGPT(String message) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'), // 변경된 엔드포인트
      headers: {
        'Authorization': 'Bearer ', // API 키를 여기에 넣으세요.
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo', // GPT 3.5 터보 모델 사용
        'messages': [
          {
            'role': 'user',
            'content': message,
          }
        ], // 메시지 배열로 변경됩니다.
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      String reply =
          data['choices'][0]['message']['content'].trim(); // 변경된 응답 구조에 맞게 접근
      setState(() {
        messages.add("You: $message");
        messages.add("GPT: $reply");
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load data: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPT-4 Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(messages[index]),
              ),
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
                      labelText: 'Enter your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
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
