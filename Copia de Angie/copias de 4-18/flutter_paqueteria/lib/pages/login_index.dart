
// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, unnecessary_new, deprecated_member_use, use_build_context_synchronously, unused_element, non_constant_identifier_names, avoid_unnecessary_containers

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:flutter_paqueteria/util/ResponseApi.dart';
import 'package:flutter_paqueteria/util/usuarios.dart';
import 'package:flutter_paqueteria/pages/home_page.dart';

class LoginPageIndex extends StatefulWidget {
  static String id = 'loginpage';

  const LoginPageIndex({super.key});

  @override
  State<LoginPageIndex> createState() => _LoginPageIndexState();
}

class _LoginPageIndexState extends State<LoginPageIndex> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usuario = TextEditingController();
  final TextEditingController clave = TextEditingController();

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/300.gif',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/Logo02.png',
                  width: 150.0,
                  height: 150.0,
                ),
              ),
            ],
          ),
          Positioned(
  bottom: 50.0,
  left: 20.0,
  right: 20.0,
  child: ConstrainedBox(
    constraints: BoxConstraints(maxWidth: 500),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.login),
          label: Text(
            'Inicia Sesión',
            style: TextStyle(fontSize: 20.0),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 5, 3, 139)),
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(vertical: 20.0),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.person),
          label: Text(
            'Invitado',
            style: TextStyle(fontSize: 20.0),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 39, 160, 2)),
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(vertical: 20.0),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
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