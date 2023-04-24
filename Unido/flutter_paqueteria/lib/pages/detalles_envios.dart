import 'package:flutter/material.dart';
import 'package:flutter_paqueteria/pages/ejemplo.dart';
import 'package:flutter_paqueteria/pages/paquetes_libres.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_paqueteria/util/responseApi.dart';


class EnviosDetalle extends StatefulWidget {
  final int envios;
  

  const EnviosDetalle({Key? key, required this.envios}) : super(key: key);
  

  @override
  _EnviosDetalleState createState() => _EnviosDetalleState();
  
}

class _EnviosDetalleState extends State<EnviosDetalle> {
  
  late Future<dynamic> _listado;

  @override
  void initState() {
    super.initState();
   _listado = _getListado(widget.envios);
   
  }

 // String url = "http://empaquetadora-ecopack.somee.com/api/Paquetes/List";
 
 Future<dynamic> _getListado(int envio) async {
  final url = "https://localhost:44356/api/EnviosPorPaquete/PaquetesPorEnvio";
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'enpa_Envio': envio});

  final respuesta = await http.post(Uri.parse(url), headers: headers, body: body);
  if (respuesta.statusCode == 200) {
   final json = respuesta.body;
  
      return jsonDecode(json);
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListadoEnvios()),
              );
            },
          ),
            backgroundColor: Colors.green[400],
        ),
        body:
        Column(
          children: [
            InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListadoPaquetesLibres(envios : widget.envios)),
    );
  },
  child: Container(
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
          "Asignar Paquete",
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
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
                "Código: #${envio["paqu_Codigo"]}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Cliente: ${envio["cliente"]}\nCiudad: ${envio["ciud_Descri"]}\nDireccion: ${envio["paqu_DireccionExacta"]}\nObservaciones: ${envio["paqu_Observaciones"]}\nEstado: ${envio["estadoViaje"]}",
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
        _eliminarEnvio(context,widget.envios.toString(),envio["paqu_Id"].toString());
        break;
      case "detalles":
        _Entregar(context,envio["paqu_Id"].toString());
        break;                            
    }
  },
  itemBuilder: (BuildContext context) {
    bool entregado = envio["estadoViaje"] == "Entregado"; 
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
        enabled: !entregado, 
      ),
      PopupMenuItem<String>(
        value: "detalles",
        child: Row(
          children: [
            Icon(Icons.details),
            SizedBox(width: 8),
            Text("Entregado"),
          ],
        ),
        enabled: !entregado, // deshabilitar si entregado es verdadero
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
void _eliminarEnvio(BuildContext context,String IDenvio, String IDpaquete) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Image.asset(
              "images/Alerta.png", 
              height: 40, 
              width: 40,
            ),
            SizedBox(width: 8), //
            Text("Eliminar el Paquete"), 
          ],
        ),
        content: Text("¿Estás seguro de que deseas eliminar este paquete?"),
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
             _Eliminar(context,IDpaquete,IDenvio);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<responseApi> _Eliminar(BuildContext context, String IDPaquete, String IDEnvio) async {

  Map<String, dynamic> datosEnpaquete = {
   
  "enpa_Id": 0,
  "enpa_Envio": int.parse(IDEnvio),
  "enpa_Paquete": int.parse(IDPaquete),
  "enpa_UsuarioCrea": 0,
  "enpa_FechaCrea": "2023-04-21T05:43:43.084Z",
  "enpa_UsuarioModifica": 0,
  "enpa_FechaModifica": "2023-04-21T05:43:43.084Z",
  "paqu_Id": 0,
  "paqu_Codigo": 0,
  "paqu_DireccionExacta": "",
  "paqu_Observaciones": "",
  "cliente": "",
  "ciud_Descri": "",
  "estadoViaje": "",
  "enpa_Estado": true
  };

  String date = jsonEncode(datosEnpaquete);

  try {
    final response = await http.post(Uri.parse('https://localhost:44356/api/EnviosPorPaquete/Delete'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: date);

    if (response.statusCode == 200) {
      if (responseApi.fromJson(jsonDecode(response.body)).data != null) {
        Fluttertoast.showToast(
          msg: "Envío eliminado exitosamente",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        ).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EnviosDetalle(envios: widget.envios)))); // Recarga la página después de que se haya agregado el envío exitosamente
        return responseApi.fromJson(jsonDecode(response.body));
      } else {
        final responseData = jsonDecode(response.body);
        final responseApi = ResponseApi.fromJson(responseData);
        Fluttertoast.showToast(
          msg: 'Ha ocurrido un error',
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
        data: new Envio(
          enpa_Id: 0,
          enpa_Envio: 0,
          enpa_Paquete: 0,
          enpa_UsuarioCrea: 0,
          enpa_FechaCrea: DateTime.now(),
          enpa_UsuarioModifica: 0,
          enpa_FechaModifica: DateTime.now(),
          paqu_Id: 0,
          paqu_Codigo: 0,
          paqu_DireccionExacta: "",
          paqu_Observaciones: "",
          cliente: "",
          ciud_Descri: "",
          estadoViaje: "",
          enpa_Estado: true
    )
    );


    } catch (e) {
      throw Exception(e);
    }
  }

  Future<responseApi> _Entregar(BuildContext context, String IDPaquete) async {

  Map<String, dynamic> datosEnpaquete = {
   
  "enpa_Id": 0,
  "enpa_Envio": 0,
  "enpa_Paquete": int.parse(IDPaquete),
  "enpa_UsuarioCrea": 0,
  "enpa_FechaCrea": "2023-04-21T05:43:43.084Z",
  "enpa_UsuarioModifica": 0,
  "enpa_FechaModifica": "2023-04-21T05:43:43.084Z",
  "paqu_Id": 0,
  "paqu_Codigo": 0,
  "paqu_DireccionExacta": "",
  "paqu_Observaciones": "",
  "cliente": "",
  "ciud_Descri": "",
  "estadoViaje": "",
  "enpa_Estado": true
  };

  String date = jsonEncode(datosEnpaquete);

  try {
    final response = await http.post(Uri.parse('https://localhost:44356/api/EnviosPorPaquete/Entregado'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: date);

    if (response.statusCode == 200) {
      if (responseApi.fromJson(jsonDecode(response.body)).data != null) {
        Fluttertoast.showToast(
          msg: "Paquete Entregado exitosamente",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        ).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EnviosDetalle(envios: widget.envios)))); // Recarga la página después de que se haya agregado el envío exitosamente
        return responseApi.fromJson(jsonDecode(response.body));
      } else {
        final responseData = jsonDecode(response.body);
        final responseApi = ResponseApi.fromJson(responseData);
        Fluttertoast.showToast(
          msg: 'Ha ocurrido un error',
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
        data: new Envio(
          enpa_Id: 0,
          enpa_Envio: 0,
          enpa_Paquete: 0,
          enpa_UsuarioCrea: 0,
          enpa_FechaCrea: DateTime.now(),
          enpa_UsuarioModifica: 0,
          enpa_FechaModifica: DateTime.now(),
          paqu_Id: 0,
          paqu_Codigo: 0,
          paqu_DireccionExacta: "",
          paqu_Observaciones: "",
          cliente: "",
          ciud_Descri: "",
          estadoViaje: "",
          enpa_Estado: true
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
