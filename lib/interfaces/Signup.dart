import 'package:flutter/material.dart';
import 'package:projet_java_support_ai/interfaces/Signup1.dart';
import 'package:projet_java_support_ai/interfaces/Signup2.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isLargeScreen = screenSize.width > 1200;
    final bool isMediumScreen =
        screenSize.width <= 1200 && screenSize.width > 768;
    final bool isSmallScreen = screenSize.width <= 768;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Créer Compte',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            centerTitle: true,
            backgroundColor: Color(0xFF4D55CC),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          backgroundColor: Color(0xFF4D55CC),
          body: Column(
            children: [
              TabBar(tabs: [
                Tab(
                  child: Text(
                    'Client',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Support',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ]),
              Expanded(
                  child: TabBarView(
                children: [
                  Signup1(),
                  Signup2(),
                ],
              )),
            ],
          ),
        ));
  }
}
