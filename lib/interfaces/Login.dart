import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_java_support_ai/.env';
import 'dart:convert';
import 'package:projet_java_support_ai/interface_admin/all_categ_admin.dart';
import 'package:projet_java_support_ai/interface_support_technique/All_problemes.dart';
import 'package:projet_java_support_ai/interface_support_technique/testprob.dart';
import 'package:projet_java_support_ai/interfaces/Home_page.dart';
import 'package:projet_java_support_ai/interfaces/Signup.dart';
import 'package:projet_java_support_ai/interfaces/Signup1.dart';
import 'package:projet_java_support_ai/interfaces/betweenpage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String dropdownvalue = "Client";
  var items = ["Client", "Support technique", "Admin"];

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nomutilisateurcontroller =
      TextEditingController();

  Future<void> login() async {
    final url = Uri.http('$ip:8000', '/login/');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "role": dropdownvalue
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Navigate based on role
        if (dropdownvalue == "Support technique") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Problems(email: emailController.text)),
          );
        } else if (dropdownvalue == "Client") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Scrollbetweenpages()),
          );
        }
      } else if (response.statusCode == 401) {
        _showErrorDialog(responseBody["error"] ?? "Invalid credentials");
      } else {
        _showErrorDialog(responseBody["error"] ?? "Login failed");
      }
    } catch (e) {
      _showErrorDialog("Error: $e");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = dropdownvalue == "Admin";

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Entrer votre email";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return "Please Enter a valid email";
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final nomutilisateurfield = TextFormField(
      autofocus: false,
      controller: nomutilisateurcontroller,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return "Entrer votre nom d'utilisateur";
        }
        return null;
      },
      onSaved: (value) {
        nomutilisateurcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.supervised_user_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Nom Utilisateur",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return "Entrer votre mot de passe";
        }
        if (!regex.hasMatch(value)) {
          return "Enter Valid Password(Min. 6 Character)";
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Mot de passe",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF4D55CC),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            login();
            if (dropdownvalue == "Admin" ||
                (emailController.text == "admin" &&
                    passwordController.text == "adminadmin")) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          all_categ_admin())); // Navigate to Admin page
            }
          }
        },
        child: Text(
          "Se Connecter",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 230,
                        child: Image.asset(
                          "assets/online.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 15),
                    if (!isAdmin) emailField,
                    if (isAdmin) nomutilisateurfield,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 25),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 5, right: 20),
                              child: Text(
                                'Role :',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 50,
                          child: DropdownButton(
                            value: dropdownvalue,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: TextStyle(color: Colors.black45),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                            underline: Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    loginButton,
                    SizedBox(height: 18),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Je n'ai pas de compte ? ",
                            style: TextStyle(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            child: Text(
                              "S'inscrire",
                              style: TextStyle(
                                  color: Color(0xFF4D55CC),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
