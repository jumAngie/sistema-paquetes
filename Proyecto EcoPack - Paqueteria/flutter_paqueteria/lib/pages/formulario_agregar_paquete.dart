// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_paqueteria/util/responseApi.dart';
import 'package:flutter_paqueteria/pages/paquetes_index_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';


final TextEditingController _observationsController = TextEditingController();
final _packageCodeController = TextEditingController();
final direccionController = TextEditingController();


  String code = "";
  String client = "";
  int department = 0;
  String city = "";
  String direccion = "";
  String observations = "";
  
  


class Departamento {
  final String id;
  final String descripcion;

  Departamento({required this.id, required this.descripcion});

  factory Departamento.fromJson(Map<String, dynamic> json) {
    return Departamento(
      id: json['depa_ID'],
      descripcion: json['depa_Descripcion'],
    );
  }
}

class Ciudad {
  final int ciud_ID;
  final String ciud_Descri;
  final int depa_ID;
  final int ciud_UsuarioCrea;
  final DateTime? ciud_FechaCrea;
  final int? ciud_UsuarioModifica;
  final DateTime? ciud_FechaModifica;
  final dynamic depa;
  final List<dynamic> tblPaquetes;

  Ciudad({
    required this.ciud_ID,
    required this.ciud_Descri,
    required this.depa_ID,
    required this.ciud_UsuarioCrea,
    this.ciud_FechaCrea,
    this.ciud_UsuarioModifica,
    this.ciud_FechaModifica,
    required this.depa,
    required this.tblPaquetes,
  });

  factory Ciudad.fromJson(Map<String, dynamic> json) {
    return Ciudad(
      ciud_ID: json['ciud_ID'],
      ciud_Descri: json['ciud_Descri'],
      depa_ID: json['depa_ID'],
      ciud_UsuarioCrea: json['ciud_UsuarioCrea'],
      ciud_FechaCrea: json['ciud_FechaCrea'] != null ? DateTime.parse(json['ciud_FechaCrea']) : null,
      ciud_UsuarioModifica: json['ciud_UsuarioModifica'],
      ciud_FechaModifica: json['ciud_FechaModifica'] != null ? DateTime.parse(json['ciud_FechaModifica']) : null,
      depa: json['depa'],
      tblPaquetes: json['tblPaquetes'] ?? [],
    );
  }
}



class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
 

      int _selectedClient = -1;
      List<dynamic> _client = [];
      String _selectedDepartment = "";
      List<String> _selectedCityList = [];
      List<Ciudad> _cityList = [];
      Ciudad? _selectedCity;

     


     
  



Future<List<Departamento>> fetchDepartamentos() async {
  final response = await http.get(Uri.parse('http://ecopack.somee.com/api/Departamentos/Departa'));
  
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    List<Departamento> departamentos = data.map((json) => Departamento(
      id: json['depa_ID'].toString(),
      descripcion: json['depa_Descri']
    )).toList();
    return departamentos;
  } else {
    throw Exception('Error al cargar Departamentos');
  }
}



List<Departamento> _departmentList = [];

void _loadDepartments() async {
  try {
    List<Departamento> departments = await fetchDepartamentos();
    setState(() {
      _departmentList = departments;
      _selectedDepartment = departments[0].id; // asignamos el primer departamento como valor inicial
    });
    await fetchCiudades(_selectedDepartment); // cargamos las ciudades del departamento inicial
  } catch (e) {
    print('Error: $e');
  }
}


Future<List<Ciudad>> fetchCiudades(String _selectedDepartment) async {
  final response = await http.post(Uri.parse('http://ecopack.somee.com/api/Departamentos/CiudadesPorDepto'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'ciud_ID': 0,
      'ciud_Descri': 'string',
      'depa_ID':  int.parse(_selectedDepartment),
    }),
  );

  if (response.statusCode == 200) {
   
    List<dynamic> data = jsonDecode(response.body);
    List<Ciudad> ciudades = data.map((json) => Ciudad.fromJson(json)).toList();
    setState(() {
      _cityList = ciudades;
    });
    return ciudades;
  } else {
    throw Exception('Error al cargar ciudades');
  }
}





@override
  void initState() {
    super.initState();
     _getClientData();
     fetchDepartamentos();
     _loadDepartments();
     
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        title: Text('Registrar paquete'),
         backgroundColor: Colors.green[400],
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
             TextFormField(
  decoration: InputDecoration(
    labelText: 'Código de paquete',
    border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                         prefixIcon: Icon(Icons.numbers), 
  ),
  keyboardType: TextInputType.number,
  controller: _packageCodeController,
   validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese una observación';
    }
    return null;
  },
  inputFormatters: <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly
  ],
),

SizedBox(
              height: 15,
             ),
             InputDecorator(
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Seleccione un Cliente',
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     prefixIcon: Icon(Icons.person)
  ),
               child: DropdownButtonFormField(
                   value: _selectedClient,
                   onChanged: (value) {
                     setState(() {
                       _selectedClient = value;
                     });
                   },
                   items: _client.map<DropdownMenuItem<dynamic>>((cliente) {
                     return DropdownMenuItem<dynamic>(
                       value: cliente['pers_Id'],
                       child: Text(cliente['cliente']),
                     );
                   }).toList(),
                   decoration: InputDecoration(
                     labelText: 'Cliente',
                   ),
                   validator: (value) {
                     if (value == null) {
                       return 'Por favor, seleccione un cliente';
                     }
                     return null;
                  },
               ),
             ),
             SizedBox(
              height: 10,
             ),
InputDecorator(
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Seleccione un departamento',
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    prefixIcon: Icon(Icons.place_outlined)
  ),
  child: DropdownButton<String>(
    value: _selectedDepartment,
    isExpanded: true,
    underline: SizedBox(),
    items: _departmentList.map((departamento) {
      return DropdownMenuItem<String>(
        value: departamento.id,
        child: Text(departamento.descripcion),
      );
    }).toList(),
    onChanged: (value) async {
      setState(() {
        _selectedDepartment = value!;
        _selectedCity = null;
        _cityList.clear();
      });

      List<Ciudad> cities = await fetchCiudades(value.toString());

      setState(() {
        _cityList = cities;
      });
    },
  ),
),

 SizedBox(
              height: 10,
             ),
InputDecorator(
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Seleccione una Ciudad',
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    prefixIcon: Icon(Icons.place)
  ),
  child:   DropdownButton<Ciudad>(
  
    
  
    value: _selectedCity,
  
    hint: Text('Seleccione una ciudad'),
  
    items: _cityList.map((ciudad) {
  
      return DropdownMenuItem<Ciudad>(
  
        value: ciudad,
  
        child: Text(ciudad.ciud_Descri),
  
      );
  
    }).toList(),
  
    onChanged: (Ciudad? value) {
  
      setState(() {
  
        _selectedCity = value;
  
       
  
      });
  
    },
  
  ),
),
 SizedBox(
              height: 12,
             ),
              TextFormField(
  controller: direccionController,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese una Direccion';
    }
    return null;
  },
  decoration: InputDecoration(
    prefixIcon: Icon(Icons.home_filled),
    border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          
                        ),
    labelText: 'Dirección Exacta',
  ),
),
 SizedBox(
              height: 12,
             ),
             TextFormField(
  decoration: InputDecoration(
    prefixIcon: Icon(Icons.pending_actions_outlined),
    border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
    labelText: 'Observaciones',
  ),
  controller: _observationsController,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese una observación';
    }
    return null;
  },
),
          SizedBox(height: 16.0),
           ElevatedButton(
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 39, 160, 2)),
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(vertical: 20.0),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
  onPressed: () {
    // Obtener los valores de los campos
    final String code = _packageCodeController.text;
    final String client = _selectedClient.toString();
    final String city = _selectedCity?.ciud_ID.toString() ?? '';
    final String direccion = direccionController.text;
    final String observations = _observationsController.text;

    // Validar que todos los campos estén llenos
    if (code.isNotEmpty &&
        client.isNotEmpty &&
        city.isNotEmpty &&
        direccion.isNotEmpty &&
        observations.isNotEmpty) {
      // Enviar los datos si todo está bien
      _enviarDatos(int.parse(code), int.parse(client), int.parse(city), direccion, observations);
    } else {
      // Mostrar un mensaje de error si algún campo está vacío
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
            Text("Error"), // texto del encabezado
          ],
        ),
            content: Text('Todos los campos son obligatorios.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  },
  child: Text('Registrar paquete'),
)



            ],
          ),
        ),
      ),
    );

    
  }

  Future<responseApi> _enviarDatos(int Codigo, int Cliente, int Ciudad, String paqu_DireccionExacta, String Observaciones) async {
      
      int UsuarioID = await SessionManager().get("Usuario");
     
      Map<String, dynamic> Datos = {
         
            "paqu_Id": 0,
            "paqu_Codigo": Codigo,
            "paqu_Cliente": Cliente,
            "paqu_Ciudad": Ciudad,
            "depa_Descri": "string",
            "ciud_Descri": "string",
            "cliente": "string",
            "paqu_DireccionExacta": paqu_DireccionExacta,
            "paqu_Observaciones": Observaciones,
            "paqu_Bodega": "2023-04-22T20:31:04.472Z",
            "paqu_EnCamino": "2023-04-22T20:31:04.472Z",
            "paqu_Entregado": "2023-04-22T20:31:04.472Z",
            "paqu_UsuarioCrea": UsuarioID,
            "paqu_FechaCrea": "2023-04-22T20:31:04.472Z",
            "paqu_UsuarioModifica": 0,
            "paqu_FechaModifica": "2023-04-22T20:31:04.472Z",
            "paqu_Estado": true

        
    };

    String date = jsonEncode(Datos);
   
    try {
     // final response = await http.post(Uri.parse('http://empaquetadora-ecopack.somee.com/api/Envios/Insertar'),
      final response = await http.post(Uri.parse('http://ecopack.somee.com/api/Paquetes/Insertar'),
       
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },  
        body: date);

      if (response.statusCode == 200) {
  
       if (responseApi.fromJson(jsonDecode(response.body)).data != null) {
        _observationsController.clear();
        _packageCodeController.clear();
        direccionController.clear();
        Fluttertoast.showToast(
            msg: "Paquete agregado exitosamente",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 4, 
              backgroundColor: Colors.blueAccent,
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
                    codigo: Codigo,
                    cliente: Cliente,
                    ciudad: Ciudad,
                    direccion: paqu_DireccionExacta,
                    observaciones: Observaciones
                    )
        );
    } catch (e) {
      throw Exception(e);
    }
  }


   Future<responseApi> Eliminar(int paqu_Id) async {
      
      int UsuarioID = await SessionManager().get("Usuario");
     
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
            "paqu_UsuarioModifica": UsuarioID,
            "paqu_FechaModifica": "2023-04-22T20:31:04.472Z",
            "paqu_Estado": true

        
    };

    String date = jsonEncode(Datos);
   
    try {
     // final response = await http.post(Uri.parse('http://empaquetadora-ecopack.somee.com/api/Envios/Insertar'),
      final response = await http.post(Uri.parse('http://ecopack.somee.com/api/Paquetes/Insertar'),
       
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },  
        body: date);

      if (response.statusCode == 200) {
  
       if (responseApi.fromJson(jsonDecode(response.body)).data != null) {
        _observationsController.clear();
        _packageCodeController.clear();
        direccionController.clear();
        Fluttertoast.showToast(
            msg: "Paquete Eliminado exitosamente",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 4, 
              backgroundColor: Colors.blueAccent,
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

  Future<Map<String, dynamic>> _getClientData() async {
  try {
    final response = await http.get(
      //Uri.parse('http://empaquetadora-ecopack.somee.com/api/Camiones/DDLCamiones'),
          Uri.parse('http://ecopack.somee.com/api/Departamentos/ClientesDDL'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      if (data.isNotEmpty) {
        setState(() {
          _client = data;
          _selectedClient = data[0]['pers_Id'];
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



