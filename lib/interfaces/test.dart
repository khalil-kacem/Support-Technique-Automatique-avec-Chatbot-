import 'dart:convert'; // Required for JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

final apiKey = "AIzaSyDuyrba8Qjj4CME8BR6JiLL9vlWkkfedFs";

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatApp extends StatefulWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  TextEditingController messageController = TextEditingController();
  List<ChatMessage> chatMessages = [];
  @override
  void sendMessage(String message) async {
    final prompt = '''
  Vous êtes un expert de support des entreprises. Vous ne répondez qu'aux questions concernant le support des entreprises. Veuillez répondre en français. 
  L'utilisateur a demandé : "$message"
  ''';

    final response = await http.post(
      Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyCr_x-weCOj02ZNCTbtFuvnujRz6acy918'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final aiResponse =
          jsonResponse["candidates"][0]["content"]["parts"][0]["text"];

      setState(() {
        chatMessages.add(ChatMessage(text: message, isUser: true));
        chatMessages.add(ChatMessage(text: aiResponse, isUser: false));
      });
    } else {
      print('Error: ${response.statusCode}');
      print('Body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4D55CC),
        title: const Text(
          "Support IA",
        ),
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 30,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                return ChatBubble(
                  text: message.text,
                  isUser: message.isUser,
                );
              },
            ),
          ),
          Container(
            color: Color(0xFF4D55CC),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Entrer votre message",
                        hintStyle: GoogleFonts.cairo(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                      style: GoogleFonts.cairo(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFF4D55CC),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (messageController.text.trim().isNotEmpty) {
                          sendMessage(messageController.text);
                          messageController.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({
    Key? key,
    required this.text,
    required this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            Container(
              width: 30,
              child: Image.asset(
                'assets/robot.png',
                fit: BoxFit.fill,
              ),
            ),
          SizedBox(
            width: 10,
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isUser ? Color(0xFFE5E3D4) : Color(0xFFE5E3D4),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              text,
              style: GoogleFonts.cairo(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
