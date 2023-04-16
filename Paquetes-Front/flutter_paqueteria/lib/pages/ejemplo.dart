// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(ListadoEnvios());
}

class ListadoEnvios extends StatefulWidget {
  const ListadoEnvios({Key? key}) : super(key: key);

  @override
  _ListadoEnviosState createState() => _ListadoEnviosState();
}

class _ListadoEnviosState extends State<ListadoEnvios> {
  late Future<dynamic> _listado;

  @override
  void initState() {
    super.initState();
    _listado = _getListado();
  }

  String url = "http://empaquetadora-ecopack.somee.com/api/Envios/List";

  Future<dynamic> _getListado() async {
    final respuesta = await http.get(Uri.parse(url));
    if (respuesta.statusCode == 200) {
      final json = respuesta.body;
      return jsonDecode(json);
    } else {
      print("Error con la respuesta");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Listado de envíos"),
        ),
        body: FutureBuilder<dynamic>(
          future: _listado,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              List<dynamic> listaDeEnvios = snapshot.data;

              return ListView.builder(
                itemCount: listaDeEnvios.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> envio = listaDeEnvios[index];
                  return Card(
                    color: Colors.green[100],
                    margin: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.green,
                            child: Text(
                              "🚛",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  "Envío ID: ${envio["envi_Id"]}",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "ID del Camión: ${envio["envi_Camion"]}\nNombre del transportista: ${envio["transportista"]}\nFecha de salida: ${envio["envi_FechaSalida"]}",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
