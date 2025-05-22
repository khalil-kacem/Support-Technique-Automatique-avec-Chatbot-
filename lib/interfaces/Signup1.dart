import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projet_java_support_ai/interfaces/Login.dart';
import 'package:http/http.dart' as http;
import 'package:projet_java_support_ai/.env';

class Signup1 extends StatefulWidget {
  @override
  _Signup1State createState() => _Signup1State();
}

class _Signup1State extends State<Signup1> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _nomController = new TextEditingController();
  final TextEditingController _refController = new TextEditingController();
  Future<bool> addUser(
    String username,
    String email,
    String password,
    String ref,
  ) async {
    final url = Uri.http('${ip}:8000', 'addClient/');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nom': username,
          'email': email,
          'password': password,
          'ref_entreprise': ref,
        }),
      );

      // Debug output
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Accept 200 or 201 as success
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('User added successfully');
        return true;
      } else {
        print('Failed to add user. '
            'Status: ${response.statusCode}, '
            'Body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred while adding user: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '''S'inscrire''',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 20.71,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: TextFormField(
                            onChanged: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Entrer votre Nom';
                              }
                              return null;
                            },
                            controller: _nomController,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Nom",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: TextFormField(
                            onChanged: (value) {},
                            autofocus: false,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Entrer votre email");
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please Enter a valid email");
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            onSaved: (value) {
                              _emailController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: TextFormField(
                            controller: _passwordController,
                            onChanged: (value) {},
                            validator: (value) {
                              RegExp regex = new RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return ("Entrer votre mot de passe");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter Valid Password(Min. 6 Character)");
                              }
                            },
                            obscureText: !_isPasswordVisible,
                            onSaved: (value) {
                              _passwordController.text = value!;
                            },
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.vpn_key),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Mot de passe",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: TextFormField(
                            onChanged: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '''Entrer votre réf d'entreprise''';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            controller: _refController,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Ref d'entreprise",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 54.6,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              bool success = await addUser(
                                _nomController.text,
                                _emailController.text,
                                _passwordController.text,
                                _refController.text,
                              );

                              if (success) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Échec de la création du compte.')),
                                );
                              }
                            } else {
                              print('Form not valid');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                            backgroundColor: Color(0xFF4D55CC),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Créer Compte',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            'Vous avez déjà un compte',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
