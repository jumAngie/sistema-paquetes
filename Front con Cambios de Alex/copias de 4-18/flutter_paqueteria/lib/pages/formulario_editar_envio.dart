import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paqueteria/pages/ejemplo.dart';

import 'dart:html';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:flutter_paqueteria/util/ResponseApi.dart';
import 'package:flutter_paqueteria/util/camiones.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_paqueteria/util/envios.dart';




class EditForm extends StatefulWidget {
  final int id;
  EditForm({Key? key, required this.id}) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();
  
  int _selectedCamion = -1;
  List<dynamic> _camiones = [];
  DateTime _selectedDate = DateTime.now();
   late DateTime _fechaEnvio;
  
  
  Future<Map<String, dynamic>> _CargarDatos() async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/${widget.id}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _selectedCamion = data['title'];
      _selectedDate = data['body'];
      return data;
    } else {
      throw Exception('Failed to load post');
    }
  }



  @override
  void initState() {
    super.initState();
    print(widget.id);
    _CargarDatos();

    Cargarddl();
    _fechaEnvio = DateTime.now();
     

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                value: _selectedCamion,
                onChanged: (value) {
                  setState(() {
                    _selectedCamion = value;
                  });
                },
                items: _camiones.map<DropdownMenuItem<dynamic>>((camion) {
                  return DropdownMenuItem<dynamic>(
                    value: camion['cami_Id'],
                    child: Text(camion['transportista']),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Camión',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, seleccione un camión';
                  }
                  return null;
                },
              ),
              Container(
  margin: EdgeInsets.symmetric(vertical: 20),
  padding: EdgeInsets.all(10),
  decoration: BoxDecoration(
    border: Border.all(
      color: Colors.grey,
      width: 1.0,
    ),
    borderRadius: BorderRadius.circular(5.0),
  ),
  child: Column(
    children: [
      Center(
        child: Text(
          'Fecha y hora de salida',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 10),
      GestureDetector(
        child: Text(
          _fechaEnvio == null ? 'Seleccione una fecha y hora' : DateFormat('yyyy-MM-dd HH:mm').format(_fechaEnvio),
          style: TextStyle(fontSize: 16),
        ),
        onTap: () {
          DatePicker.showDateTimePicker(
            context,
            showTitleActions: true,
            onConfirm: (date) {
              setState(() {
                _fechaEnvio = date;
              });
            },
            currentTime: DateTime.now(),
          );
        },
      ),
    ],
  ),
),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      
                      _enviarDatos(0,_selectedCamion,_selectedDate.toString(),1,DateTime.parse("2023-04-18T19:30:45.375Z"),0,DateTime.parse("2023-04-18T19:30:45.375Z"),true);
                    }
                  },
                  child: Text('Agregar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<Map<String, dynamic>> Cargarddl() async {
  try {
    final response = await http.get(
      //Uri.parse('http://empaquetadora-ecopack.somee.com/api/Camiones/DDLCamiones'),
          Uri.parse('https://localhost:44356/api/Camiones/DDLCamiones'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      if (data.isNotEmpty) {
        setState(() {
          _camiones = data;
          _selectedCamion = data[0]['cami_Id'];
        });
        return data[0];
      } else {
        throw Exception('La respuesta es nula');
      }
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<responseApi> _enviarDatos(int envi_Id, int envi_Camion,
      String envi_FechaSalida, int envi_UsuarioCrea , DateTime envi_FechaCrea, 
      int envi_UsuarioModifica, DateTime envi_FechaModifica, bool envi_Estado) async {
        print(envi_FechaSalida);
      Map<String, dynamic> DatosUser = {
          "envi_Id": 0,
          "envi_Camion": envi_Camion,
          "envi_FechaSalida": envi_FechaSalida,
          "envi_UsuarioCrea": envi_UsuarioCrea,
          "envi_FechaCrea": "2023-04-18T21:38:28.813Z",
          "envi_UsuarioModifica": 0,
          "envi_FechaModifica": "2023-04-18T21:38:28.813Z",
          "envi_Estado": true

        
    };

    String date = jsonEncode(DatosUser);
   
    try {
     // final response = await http.post(Uri.parse('http://empaquetadora-ecopack.somee.com/api/Envios/Insertar'),
      final response = await http.post(Uri.parse('https://localhost:44356/api/Envios/Insertar'),
       
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
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  ).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListadoEnvios()))); // Recarga la página después de que se haya agregado el envío exitosamente
  return responseApi.fromJson(jsonDecode(response.body));
} else {
  final responseData = jsonDecode(response.body);
  final responseApi = ResponseApi.fromJson(responseData);
  Fluttertoast.showToast(
    msg: responseApi.message ?? 'Ha ocurrido un error',
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
                    envi_Estado: envi_Estado)
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
