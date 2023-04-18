import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_paqueteria/util/ResponseApi.dart';
import 'package:flutter_paqueteria/util/envios.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddEnvioForm extends StatefulWidget {
  @override
  _AddEnvioFormState createState() => _AddEnvioFormState();
}

class _AddEnvioFormState extends State<AddEnvioForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _camionController = TextEditingController();
  final TextEditingController _fechaSalidaController = TextEditingController();
  final TextEditingController _usuarioCreaController = TextEditingController();
  int _selectedCamion = -1;
  List<dynamic> _camiones = [];
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    Cargarddl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar envío'),
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
              TextFormField(
                controller: _fechaSalidaController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: 'Fecha de salida',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, ingrese la fecha de salida';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usuarioCreaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Usuario que crea el envío',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, ingrese el usuario que crea el envío';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _enviarDatos();
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




  void _enviarDatos() async { 
    final url = 'https://tu-api.com/envios';
    final response = await http.post(Uri.parse(url), body: {
      'envi_Camion': _camionController.text,
      'envi_FechaSalida': _fechaSalidaController.text,
      'envi_UsuarioCrea': _usuarioCreaController.text,
    });
    if (response.statusCode == 200) {
      // Si el servidor devuelve un OK response, puedes mostrar una notificación o redirigir a la página de envíos
    } else {
      // Si el servidor devuelve un response diferente a OK, debes manejar el error
    }
  }


Future<Map<String, dynamic>> Cargarddl() async {
  try {
    final response = await http.get(
      Uri.parse('http://empaquetadora-ecopack.somee.com/api/Camiones/DDLCamiones'),
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






}
