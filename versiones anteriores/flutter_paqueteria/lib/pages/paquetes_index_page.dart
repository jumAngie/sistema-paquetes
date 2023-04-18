// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_paqueteria/navigation/bottomnavigation.dart';

String url = "http://empaquetadora-ecopack.somee.com/api/Usuarios/List"; // Cambiar por la direccion de listado de la API

Future<dynamic> _getListado() async{
  final respuesta = await http.get(Uri.parse(url));
  if(respuesta.statusCode == 200)
  {
    final json = respuesta.body;
    return jsonDecode(json);
  }
  else
  {
    print("Error con la respuesta");
  }
}

class ListadoPaquetes extends StatelessWidget {
  const ListadoPaquetes({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: BNavigator(),
       body: Center(child: Text('Paquetes')),
    );
  }
}