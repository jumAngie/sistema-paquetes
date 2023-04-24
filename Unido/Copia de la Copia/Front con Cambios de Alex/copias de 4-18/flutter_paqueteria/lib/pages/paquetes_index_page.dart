// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(ListadoPaquetes());
}

class ListadoPaquetes extends StatefulWidget {
  const ListadoPaquetes({Key? key}) : super(key: key);

  @override
  _ListadoPaquetesState createState() => _ListadoPaquetesState();
}

class _ListadoPaquetesState extends State<ListadoPaquetes> {
  late Future<dynamic> _listado;

  @override
  void initState() {
    super.initState();
    _listado = _getListado();
  }

 // String url = "http://empaquetadora-ecopack.somee.com/api/Paquetes/List";
  String url = "https://localhost:44356/api/Paquetes/List";

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
            title: Center(child: Text("Listado de Paquetes",
                                      style: TextStyle(
                                        fontWeight: 
                                        FontWeight.bold),
                                        )
                                        ),
            leading: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                        Navigator.pop(context);
                                              },
                                              ),
            backgroundColor: Colors.green[400],
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
                    "Añadir Paquete",
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
                              backgroundColor: Colors.green[400],
                              child: Text(
                                "📦",
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
                                    "Código: ${envio["paqu_Codigo"]}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "Cliente: ${envio["cliente"]}\nDepartamento: ${envio["depa_Descri"]}\nCiudad: ${envio["ciud_Descri"]}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
            PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case "eliminar":
                  _eliminarEnvio(context,envio["envi_Id"]);
                  break;
                case "detalles":
                  _verDetalles(envio);
                  break;
                case "editar":
                  _editarEnvio(envio);
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: "eliminar",
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 8),
                      Text("Eliminar"),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: "detalles",
                  child: Row(
                    children: [
                      Icon(Icons.details),
                      SizedBox(width: 8),
                      Text("Detalles"),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: "editar",
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text("Editar"),
                    ],
                  ),
                ),
              ];
            },
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
void _eliminarEnvio(BuildContext context, int envioId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Image.asset(
              "images/Alerta.png", // ruta de la imagen
              height: 40, // tamaño de la imagen
              width: 40,
            ),
            SizedBox(width: 8), // espacio entre la imagen y el texto
            Text("Eliminar envío"), // texto del encabezado
          ],
        ),
        content: Text("¿Estás seguro de que deseas eliminar este envío?"),
        actions: [
          TextButton(
            child: Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Eliminar"),
            onPressed: () {
              // TODO: Implementar lógica de eliminación de envío
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
  void _verDetalles(Map<String, dynamic> envio) {
    // TODO: Implementar lógica de visualización de detalles de envío
  }

  void _editarEnvio(Map<String, dynamic> envio) {
    // TODO: Implementar lógica de edición de envío
  }




}
