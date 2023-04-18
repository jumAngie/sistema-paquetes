// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_paqueteria/navigation/bottomnavigation.dart';


String url = "http://empaquetadora-ecopack.somee.com/api/Usuarios/List";


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


class ListadoEnvios extends StatefulWidget {

  @override
  State<ListadoEnvios> createState() => _ListadoEnviosState();
}


class _ListadoEnviosState extends State<ListadoEnvios> {
  Future<dynamic>? _futureListado;

   @override
  void initState() {
    super.initState();
    _futureListado = _getListado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Usuarios'),
      ),
      body: FutureBuilder<dynamic>(
        future: _futureListado,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> info = snapshot.data as List<dynamic>;
            return Container(
              margin: EdgeInsets.all(16.0),
              child: DataTable(
                columnSpacing: 16.0,
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Usuario')),
                  DataColumn(label: Text('Es Admin')),
                ],
                rows: info
                    .map(
                      (element) => DataRow(cells: [
                        DataCell(Text(element['usua_Id'].toString())),
                        DataCell(Text(element['usua_Usuario'])),
                        DataCell(Text(element['es_Admin'].toString())),
                      ]),
                    )
                    .toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}