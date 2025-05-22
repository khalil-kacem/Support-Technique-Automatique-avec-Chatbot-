import 'package:flutter/material.dart';
import 'package:projet_java_support_ai/interface_admin/all_clients.dart';
import 'package:projet_java_support_ai/interface_admin/clientsget.dart';
import 'package:projet_java_support_ai/interface_admin/homepage_admin.dart';
import 'package:projet_java_support_ai/interface_admin/message.dart';
import 'package:projet_java_support_ai/interface_admin/support_tech.dart';
import 'package:projet_java_support_ai/interfaces/Login.dart';
import 'package:projet_java_support_ai/testtest.dart';

class all_categ_admin extends StatefulWidget {
  const all_categ_admin({super.key});

  @override
  State<all_categ_admin> createState() => _all_categ_adminState();
}

class _all_categ_adminState extends State<all_categ_admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: const Text(
              "Vous pouvez gérer l'un des éléments suivants en sélectionnant une option ci-dessous.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Clients()));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF4D55CC),
                ),
                padding: const EdgeInsets.all(10),
                child: const Center(
                  child: Text(
                    'Client',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ), // Client
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => support_tech_affich()));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF4D55CC),
                ),
                padding: const EdgeInsets.all(10),
                child: const Center(
                  child: Text(
                    'Equipe de support',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => messages()));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF4D55CC),
                ),
                padding: const EdgeInsets.all(10),
                child: const Center(
                  child: Text(
                    'Messages',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF4D55CC),
                ),
                padding: const EdgeInsets.all(10),
                child: const Center(
                  child: Text(
                    'Déconnecter',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
