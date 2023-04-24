// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_paqueteria/util/responseApi.dart';
import 'package:flutter_paqueteria/util/envios.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:flutter_paqueteria/pages/formulario_envios.dart';
import 'package:flutter_paqueteria/pages/formulario_editar_envio.dart';
import 'package:flutter_paqueteria/pages/ejemplo.dart';

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

 // String url = "http://empaquetadora-ecopack.somee.com/api/Envios/List";
    String url = "https://localhost:44356/api/Envios/List";

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
          title: Center(
            child: Text(
              "Listado de envíos",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
           leading: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                        Navigator.pop(context);
                                              },
                                              ),
          backgroundColor: Colors.green[400],
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
                  return EnvioCard(
                    envio: envio,
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
        floatingActionButton: FloatingActionButton.extended(
  backgroundColor: Colors.green,
  icon: Icon(Icons.add),
  label: Text("Agregar"),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEnvioForm()),
    );
  },
),
      ),
    );
  }
 
   




}

 class ResponseApi {
  final int status;
  final String message;

  ResponseApi({required this.status, required this.message});

  factory ResponseApi.fromJson(Map<String, dynamic> json) {
    return ResponseApi(
      status: json['status'],
      message: json['message'],
    );
  }
}

class EnvioCard extends StatelessWidget {
  final Map<String, dynamic> envio;

  const EnvioCard({required this.envio});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 181, 255, 185),
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 30,
              backgroundColor:Colors.green[400],
              child: Text(
                "🚛",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 8, 71, 0),
                ),
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "ID del Camión: ${envio["envi_Camion"]}\nNombre del transportista: ${envio["transportista"]}\nFecha de salida: ${envio["envi_FechaSalida"]}",
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
                  _editarEnvio(context, envio);
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
  }

void _editarEnvio(BuildContext context, Map<String, dynamic> envio) {
  
  List<Envioss> envios = [
    Envioss(
      envi_Id: envio['envi_Id'],
      envi_Camion: envio['envi_Camion'],
      transportista: envio['transportista'],
      envi_FechaSalida: envio['envi_FechaSalida'],
    ),
  ];
  print(envio);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditForm(envios: envios),
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
            
                                              
               _Eliminar(context,envioId,0,'',1,DateTime.parse("2023-04-18T19:30:45.375Z"),0,DateTime.parse("2023-04-18T19:30:45.375Z"),true,'s');
            
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<responseApi> _Eliminar(BuildContext context,int envi_Id, int envi_Camion,
      String envi_FechaSalida, int envi_UsuarioCrea , DateTime envi_FechaCrea, 
      int envi_UsuarioModifica, DateTime envi_FechaModifica, bool envi_Estado, String transportista) async {
        print(envi_FechaSalida);
      Map<String, dynamic> DatosUser = {
          "envi_Id": envi_Id,
          "envi_Camion": envi_Camion,
          "envi_FechaSalida": envi_FechaSalida,
          "envi_UsuarioCrea": envi_UsuarioCrea,
          "envi_FechaCrea": "2023-04-18T21:38:28.813Z",
          "envi_UsuarioModifica": 1,
          "envi_FechaModifica": "2023-04-18T21:38:28.813Z",
          "envi_Estado": true

        
    };

    String date = jsonEncode(DatosUser);
   
    try {
     // final response = await http.post(Uri.parse('http://empaquetadora-ecopack.somee.com/api/Envios/Insertar'),
      final response = await http.post(Uri.parse('https://localhost:44356/api/Envios/Eliminar'),
       
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },  
        body: date);

      if (response.statusCode == 200) {
  
       if (responseApi.fromJson(jsonDecode(response.body)).data != null) {
  Fluttertoast.showToast(
    msg: "Envío agregado exitosamente",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 4, 
    backgroundColor: Colors.blueAccent,
    textColor: Colors.white,
    fontSize: 16.0,
 
  ).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListadoEnvios()))); // Recarga la página después de que se haya agregado el envío exitosamente
  return responseApi.fromJson(jsonDecode(response.body));
} else {
  final responseData = jsonDecode(response.body);
  final responseApi = ResponseApi.fromJson(responseData);
  Fluttertoast.showToast(
    msg:  'Ha ocurrido un error',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 4, 
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
    
      } 
        return new responseApi(
          code: 0, 
          success: false, 
          message: "Nada", 
          data: new Envios(
                    envi_Id: envi_Id,
                    envi_Camion: envi_Camion,
                    envi_FechaSalida: envi_FechaSalida,
                    envi_UsuarioCrea: envi_UsuarioCrea ,
                    envi_FechaCrea: envi_FechaCrea,
                    envi_UsuarioModifica: envi_UsuarioModifica,
                    envi_FechaModifica: envi_FechaModifica,
                    envi_Estado: envi_Estado,
                    transportista:transportista)
        );
    } catch (e) {
      throw Exception(e);
    }
  }

  void _verDetalles(Map<String, dynamic> envio) {
    // TODO: Implementar lógica de visualización de detalles de envío
  }

}






class Envioss {
  final int? envi_Id;
  final int? envi_Camion;
  final String? transportista;
  final String? envi_FechaSalida;
 

  Envioss({
    required this.envi_Id,
    required this.envi_Camion,
    required this.transportista,
    required this.envi_FechaSalida,
    
  });
}





