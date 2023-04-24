// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_paqueteria/util/responseApi.dart';
import 'package:flutter_paqueteria/pages/formulario_agregar_paquete.dart';

void main() {
  runApp(ListadoPaquetes());
}

class ListadoPaquetes extends StatefulWidget {
  const ListadoPaquetes({Key? key}) : super(key: key);

  @override
  _ListadoPaquetesState createState() => _ListadoPaquetesState();
}

class Paquetes{
  final int? codigo;
  final int? cliente;
  final int? ciudad;
  final String? direccion;
  final String? observaciones;
 

  Paquetes({
    this.observaciones,
    required this.codigo,
    required this.cliente,
    required this.ciudad,
    required this.direccion,
  });

  
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
           IconButton(
  icon: Icon(Icons.delete),
  onPressed: () {
    _eliminarEnvio(context, envio["paqu_Id"]);
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
        ),
        floatingActionButton: FloatingActionButton.extended(
  backgroundColor: Colors.green,
  icon: Icon(Icons.add),
  label: Text("Agregar"),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyForm()),
    );
  },
),
       ),
    );
  }
void _eliminarEnvio(BuildContext context, int envioId) {
  print(envioId);
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
             Eliminar(int.parse(envioId.toString()));
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
  Future<responseApi> Eliminar(int paqu_Id) async {
      
     
     
      Map<String, dynamic> Datos = {
         
            "paqu_Id": paqu_Id,
            "paqu_Codigo": 0,
            "paqu_Cliente": 0,
            "paqu_Ciudad": 0,
            "depa_Descri": "string",
            "ciud_Descri": "string",
            "cliente": "string",
            "paqu_DireccionExacta": "",
            "paqu_Observaciones": "Observaciones",
            "paqu_Bodega": "2023-04-22T20:31:04.472Z",
            "paqu_EnCamino": "2023-04-22T20:31:04.472Z",
            "paqu_Entregado": "2023-04-22T20:31:04.472Z",
            "paqu_UsuarioCrea": 0,
            "paqu_FechaCrea": "2023-04-22T20:31:04.472Z",
            "paqu_UsuarioModifica": 1,
            "paqu_FechaModifica": "2023-04-22T20:31:04.472Z",
            "paqu_Estado": true

        
    };

    String date = jsonEncode(Datos);
   
    try {
     // final response = await http.post(Uri.parse('http://empaquetadora-ecopack.somee.com/api/Envios/Insertar'),
      final response = await http.post(Uri.parse('https://localhost:44356/api/Paquetes/Eliminar'),
       
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },  
        body: date);

      if (response.statusCode == 200) {
  
       if (responseApi.fromJson(jsonDecode(response.body)).data != null) {
     
        Fluttertoast.showToast(
    msg:  'Paquete eliminado Exitosamente',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 4, 
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  
 
  ).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListadoPaquetes()))); // Recarga la página después de que se haya agregado el envío exitosamente
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
          data: new Paquetes(
                    codigo: 0,
                    cliente: 0,
                    ciudad: 0,
                    direccion: "",
                    observaciones: "Observaciones"
                    )
        );
    } catch (e) {
      throw Exception(e);
    }
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