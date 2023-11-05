import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';

// Chat 페이지는 이메일을 인자로 받도록 변경했습니다.
class Chat extends StatefulWidget {
  final String email;

  Chat({Key? key, required this.email}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = []; // 이제 메시지 리스트는 단순 문자열 리스트입니다.

  void _handleSubmitted(String text) async {
    _textController.clear();
    setState(() {
      _messages.insert(0, text); // 새 메시지를 리스트에 추가합니다.
    });

    // 서버로 메시지를 전송하는 부분...
    // TODO: 서버에 메시지를 전송하는 코드를 작성하거나 수정하세요.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, index) => _buildMessageItem(_messages[index]),
            ),
          ),
          Divider(height: 1.0),
          _buildTextComposer(),
        ],
      ),
    );
  }

  // 메시지 항목을 구성하는 위젯을 생성합니다.
  Widget _buildMessageItem(String message) {
    return Align(
      alignment: Alignment.centerRight, // 메시지를 오른쪽에 정렬합니다.
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: Colors.blue, // 여기서 메시지의 배경색을 변경할 수 있습니다.
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white, // 메시지 텍스트 색상입니다.
          ),
        ),
      ),
    );
  }

  // 텍스트 입력과 전송 버튼을 포함하는 아래쪽 텍스트 작성 영역입니다.
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
