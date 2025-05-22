import 'package:flutter/material.dart';
import 'package:projet_java_support_ai/interfaces/test.dart';

class Support_chat extends StatefulWidget {
  const Support_chat({super.key});

  @override
  State<Support_chat> createState() => _Support_chatState();
}

class _Support_chatState extends State<Support_chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              textAlign: TextAlign.center,
              "Pour toute assistance ou pour échanger avec notre assistant virtuel, veuillez cliquer ici. Notre chatbot est à votre disposition pour répondre à vos questions et vous guider",
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
            )),
            SizedBox(
              height: 35,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 64.6,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatApp()));
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  backgroundColor: Color(0xFF4D55CC),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.support_agent,
                      size: 40,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
