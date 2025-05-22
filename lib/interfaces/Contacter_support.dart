import 'dart:io';
import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projet_java_support_ai/.env';

class Contacter_support extends StatefulWidget {
  final String email;
  Contacter_support({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<Contacter_support> createState() => _Contacter_supportState();
}

class _Contacter_supportState extends State<Contacter_support> {
  final _formKey = GlobalKey<FormState>();
  final nomcontroller = TextEditingController();
  final prenomcontroller = TextEditingController();
  final DescriptionEditingController = TextEditingController();
  final refentreprisecontroller = TextEditingController();
  final QuantityEditingController = TextEditingController();
  final telEditingController = TextEditingController();

  Future<void> save() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final Map<String, String> body = {
        'nom': nomcontroller.text,
        'prenom': prenomcontroller.text,
        'description': DescriptionEditingController.text,
        'refEntreprise': refentreprisecontroller.text,
        'contactEmail': widget.email,
        'telephone': telEditingController.text,
      };

      final response = await http.post(
        Uri.parse('http://${ip}:8000/contactSupport/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Clear form fields
        nomcontroller.clear();
        prenomcontroller.clear();
        DescriptionEditingController.clear();
        refentreprisecontroller.clear();
        QuantityEditingController.clear();
        telEditingController.clear();
      } else {}
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final Nom = TextFormField(
      autofocus: false,
      controller: nomcontroller,
      onChanged: (value) {},
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("nom ne doit pas étre vide");
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Entrer votre Nom ",
        hintStyle: GoogleFonts.cairo(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final Prenom = TextFormField(
      autofocus: false,
      controller: prenomcontroller,
      onChanged: (value) {},
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("prenom ne doit pas étre vide");
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Entrer votre Prénom ",
        hintStyle: GoogleFonts.cairo(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final Description = TextFormField(
      autofocus: false,
      controller: DescriptionEditingController,
      onChanged: (value) {},
      keyboardType: TextInputType.name,
      maxLines: 7,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Cette champs ne doit pas étre vide");
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Entrer votre probléme ',
        hintStyle: GoogleFonts.cairo(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final refentreprise = Container(
      width: double.infinity,
      child: TextFormField(
        autofocus: false,
        controller: refentreprisecontroller,
        onChanged: (value) {
          try {
            double parsedValue = double.parse(value);
            setState(() {});
          } catch (e) {
            print(e.toString());
          }
        },
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return ("refentreprise ne doit pas étre vide");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Entrer votre réference d'entreprise",
          hintStyle: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );

    final Quantity = TextFormField(
      autofocus: false,
      controller: QuantityEditingController,
      onChanged: (value) {
        try {
          double parseValue = double.parse(value);
          setState(() {});
        } catch (e) {
          print(e.toString());
        }
      },
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Quantity cannot be Empty");
        }
        double quantity = double.tryParse(value)!;
        if (quantity < 10 || quantity > 180) {
          return "Quantity must be between 30 and 180 ";
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'quantity',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final RegisterButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFF4D55CC),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          if (_formKey.currentState != null &&
              _formKey.currentState!.validate()) {
            await save(); // Call the save method to send the form data to the server
          } else {
            print('Form is not valid');
          }
        },
        child: Text(
          "Envoyer formulaire",
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contacter",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Nom,
                const SizedBox(height: 20),
                Prenom,
                const SizedBox(height: 20),
                refentreprise,
                const SizedBox(height: 20),
                Container(
                  height: 45,
                  width: double.infinity,
                  child: TextFormField(
                    controller: telEditingController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      try {
                        double parsedValue = double.parse(value);
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Entrer votre numéro de telephone ',
                      hintStyle: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Description,
                const SizedBox(height: 20),
                RegisterButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
