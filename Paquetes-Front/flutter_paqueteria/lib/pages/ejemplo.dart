// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(ListadoEjemplo());
}

class ListadoEjemplo extends StatefulWidget {
  const ListadoEjemplo({Key? key}) : super(key: key);

  @override
  _ListadoEjemploState createState() => _ListadoEjemploState();
}

class _ListadoEjemploState extends State<ListadoEjemplo> {
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
          title: Text("Listado de envios"),
        ),
        body: FutureBuilder<dynamic>(
          future: _listado,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              List<dynamic> listaDePaquetes = snapshot.data;

              return ListView.builder(
                itemCount: listaDePaquetes.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> paquete = listaDePaquetes[index];
                  return Card(
                    color: Colors.green[50], // Color de fondo de la carta
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Margen de la carta
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8), // Padding del ListTile
                      title: Text(
                        paquete["envi_Id"].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green[900]), // Estilo del título
                      ),
                      subtitle: Text(
                        paquete["transportista"],
                        style: TextStyle(fontSize: 16, color: Colors.green[900]), // Estilo del subtítulo
                      ),
                      trailing: Text(
                        "⌛ ${paquete["envi_FechaSalida"]}",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow[900]), // Estilo del texto del precio
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // Por defecto, muestra un indicador de progreso
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}