import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:projet_java_support_ai/.env';

class ContenuProbleme extends StatefulWidget {
  final Map problem;

  const ContenuProbleme({Key? key, required this.problem}) : super(key: key);

  @override
  State<ContenuProbleme> createState() => _ContenuProblemeState();
}

class _ContenuProblemeState extends State<ContenuProbleme> {
  final TextEditingController DescriptionEditingController =
      TextEditingController();

  final String apiUrl = 'http://${ip}:8000/submitProblem/';

  Future<void> submitProblem() async {
    final String expediteur = widget.problem['nom'] ?? '';
    final String refEntreprise = widget.problem['refEntreprise'] ?? '';
    final String probleme = widget.problem['description'] ?? '';
    final String reponse = DescriptionEditingController.text;

    if (reponse.isEmpty) {
      // Handle the case where the response is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('La réponse ne peut pas être vide')),
      );
      return;
    }

    // Prepare the data as JSON
    final Map<String, String> data = {
      'expediteur': expediteur,
      'refEntreprise': refEntreprise,
      'probleme': probleme,
      'reponse': reponse,
    };

    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Problème et réponse envoyés avec succès!')),
        );
        // You can also navigate to another screen or refresh the page here
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'envoi')),
        );
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de connexion au serveur')),
      );
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
                    widget.problem['nom'] ?? '',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    ' ',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.problem['prenom'] ?? '',
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
                widget.problem['description'] ?? 'No problem description',
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
              TextFormField(
                autofocus: false,
                controller: DescriptionEditingController,
                maxLines: 7,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: 'Entrer votre Réponse',
                  hintStyle: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 20),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF4D55CC),
                child: MaterialButton(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: submitProblem,
                  child: Text(
                    "Envoyer",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
