// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
          ),
          ),
            title: Center(child: Text("Listado de envíos",
                                      style: TextStyle(
                                        fontWeight: 
                                        FontWeight.bold),
                                        )
                                        ),
            backgroundColor: Colors.amber[400],
        ),
        body:
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green[400]!,
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text(
                    "Añadir Envio",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
        Expanded(
          child: FutureBuilder<dynamic>(
            future: _listado,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                List<dynamic> listaDeEnvios = snapshot.data;
        
                return ListView.builder(
                  itemCount: listaDeEnvios.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> envio = listaDeEnvios[index];
                    return Card(
                      color: Color.fromARGB(255, 181, 255, 185),
                      margin: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.amber[400],
                              child: Text(
                                "🚛",
                                style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 8, 71, 0)),
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
       ],
        )
       ),
    );
  }
}
