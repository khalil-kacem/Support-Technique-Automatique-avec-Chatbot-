import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:projet_java_support_ai/.env';

class contenu_message extends StatefulWidget {
  final Map problem;

  const contenu_message({Key? key, required this.problem}) : super(key: key);

  @override
  State<contenu_message> createState() => _contenu_messageState();
}

class _contenu_messageState extends State<contenu_message> {
  final TextEditingController DescriptionEditingController =
      TextEditingController();
  List<dynamic> problemsList = [];

  Future<void> fetchProblems() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/getproblem'));

    if (response.statusCode == 200) {
      setState(() {
        problemsList = jsonDecode(response.body);
      });
    } else {
      // Handle error
      print('Failed to load problems');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Problème",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF4D55CC),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Expéditeur :',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.problem['expediteur'] ?? '',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Réf d\'entreprise :',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.problem['refEntreprise'] ?? 'No refEntreprise',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Problème :',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                widget.problem['probleme'] ?? 'No problem description',
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Réponse :',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                widget.problem['reponse'] ?? 'No reponse ',
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
