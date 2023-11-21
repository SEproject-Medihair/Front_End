import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isSentByMe;

  Message(this.text, this.isSentByMe);
}

class Chatpage extends StatelessWidget {
  final List<Message> messages = [
    Message('Hello!', false),
    Message('Hi there!', true),
    Message('How are you?', true),
    Message('I\'m good, thanks!', false),
    Message('What about you?', false),
    Message('Doing great!', true),
  ];

  Chatpage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F2E7),
        primaryColor: const Color(0xFFF9F2E7),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: (EdgeInsets.only(top: height * 0.05)),
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
                SizedBox(
                  width: width * 0.30,
                ),
                const Text(
                  '챗봇',
                  style: TextStyle(
                    color: Color(0xFF51370E),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return _buildMessageTile(message);
                },
              ),
            ),
            _buildMessageInputField(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageTile(Message message) {
    return Align(
      alignment:
          message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isSentByMe
              ? Colors.blue
              : const Color.fromARGB(255, 201, 201, 201),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          message.text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildMessageInputField() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '입력하세요...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Handle sending message
            },
          ),
        ],
      ),
    );
  }
}
