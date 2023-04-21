import 'package:flutter/material.dart';
import 'package:flutter_paqueteria/pages/ejemplo.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EnviosDetalle extends StatefulWidget {
  final int envios;
  

  const EnviosDetalle({Key? key, required this.envios}) : super(key: key);
  

  @override
  _EnviosDetalleState createState() => _EnviosDetalleState();
  
}

class _EnviosDetalleState extends State<EnviosDetalle> {
  
  late Future<List<Envio>> _listado;

  @override
  void initState() {
    super.initState();
   _listado = _getListado(widget.envios);
   
  }

 // String url = "http://empaquetadora-ecopack.somee.com/api/Paquetes/List";
 
Future<List<Envio>> _getListado(int envio) async {
  final url = "https://localhost:44356/api/EnviosPorPaquete/PaquetesPorEnvio";
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'enpa_Envio': envio});

  final respuesta = await http.post(Uri.parse(url), headers: headers, body: body);
  if (respuesta.statusCode == 200) {
     print("Datos recibidos: ${respuesta.body}");

    final dynamic json = jsonDecode(respuesta.body);
    if (json is List<dynamic>) {
      final envios = json.map((e) => Envio.fromJson(e)).toList();
      return envios;
    } else if (json is Map<String, dynamic>) {
      final envio = Envio.fromJson(json);
      return [envio];
    } else {
      print("Error al decodificar la respuesta");
      return [];
    }
  } else {
    print("Error con la respuesta");
    return [];
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
            title: Center(child: Text("Listado de Paquetes del envio #${widget.envios}",
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
                                    "Código: #${widget.envios}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "Hola",
                                    //"Cliente: ${envio["cliente"]}\nDepartamento: ${envio["depa_Descri"]}\nCiudad: ${envio["ciud_Descri"]}",
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
 
}

class Envio {
  final int? enpa_Id;
  final int? enpa_Envio;
  final int? enpa_Paquete;
  final int? enpa_UsuarioCrea;
  final DateTime? enpa_FechaCrea;
  final int? enpa_UsuarioModifica;
  final DateTime? enpa_FechaModifica;
  final int? paqu_Id;
  final int? paqu_Codigo;
  final String? paqu_DireccionExacta;
  final String? paqu_Observaciones;
  final String? cliente;
  final String? ciud_Descri;
  final String? estadoViaje;
  final bool? enpa_Estado;

  Envio({
    required this.enpa_Id,
    required this.enpa_Envio,
    required this.enpa_Paquete,
    required this.enpa_UsuarioCrea,
    required this.enpa_FechaCrea,
    required this.enpa_UsuarioModifica,
    required this.enpa_FechaModifica,
    required this.paqu_Id,
    required this.paqu_Codigo,
    required this.paqu_DireccionExacta,
    required this.paqu_Observaciones,
    required this.cliente,
    required this.ciud_Descri,
    required this.estadoViaje,
    required this.enpa_Estado,
  });

  factory Envio.fromJson(Map<String, dynamic> json) {
    return Envio(
      enpa_Id: json['enpa_Id'],
      enpa_Envio: json['enpa_Envio'],
      enpa_Paquete: json['enpa_Paquete'],
      enpa_UsuarioCrea: json['enpa_UsuarioCrea'],
      enpa_FechaCrea: DateTime.parse(json['enpa_FechaCrea']),
      enpa_UsuarioModifica: json['enpa_UsuarioModifica'],
      enpa_FechaModifica: DateTime.parse(json['enpa_FechaModifica']),
      paqu_Id: json['paqu_Id'],
      paqu_Codigo: json['paqu_Codigo'],
      paqu_DireccionExacta: json['paqu_DireccionExacta'],
      paqu_Observaciones: json['paqu_Observaciones'],
      cliente: json['cliente'],
      ciud_Descri: json['ciud_Descri'],
      estadoViaje: json['estadoViaje'],
      enpa_Estado: json['enpa_Estado'],
    );
  }
}
