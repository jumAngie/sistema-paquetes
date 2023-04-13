// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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


class ListadoUsuarios extends StatefulWidget {

  @override
  State<ListadoUsuarios> createState() => _ListadoUsuariosState();
}

class _ListadoUsuariosState extends State<ListadoUsuarios> {
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
            return DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Usuario')),
                DataColumn(label: Text('Es Admin')),
              ],
              rows: info
                  .map(
                    (element) => DataRow(cells:
                     [
                      DataCell(Text(element['usua_Id'].toString())),
                      DataCell(Text(element['usua_Usuario'])),
                      DataCell(Text(element['es_Admin'].toString())),
                    ]),
                  )
                  .toList(),
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