import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_paqueteria/util/responseApi.dart';
import 'package:flutter_paqueteria/pages/paquetes_index_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Package {
  String code = "";
  String client = "";
  int department = 0;
  String city = "";
  String direccion = "";
  String observations = "";
  
  Package({required this.code, required this.client, required this.direccion, required this.department, required this.city, this.observations = ""});
}

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
  final String ciud_Descripcion;

  Ciudad({required this.ciud_ID, required this.ciud_Descripcion});

  factory Ciudad.fromJson(Map<String, dynamic> json) {
    return Ciudad(
      ciud_ID: json['ciud_ID'],
      ciud_Descripcion: json['ciud_Descripcion'],
    );
  }
}


class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
 final Package _package = Package(city: '', code: '', client: '', department: 0, direccion: '');

      int _selectedClient = -1;
      List<dynamic> _client = [];
      String _selectedDepartment = "";
      List<String> _selectedCityList = [];

      Future<void> _handleDepartmentChange(String value) async {
          setState(() {
          _selectedDepartment = value;
          _selectedCityList = [];
  });
          final List<Ciudad> ciudadList = await fetchCiudades(value);

    setState(() {
         _selectedCityList = ciudadList.map((ciudad) => ciudad.ciud_Descripcion).toList();
  });
      }

  void _handleCodeChange(String value) {
    setState(() {
      _package.code = value;
    });
  }
  
  void _handleClientChange(String? value) {
  setState(() {
    _package.client = value ?? "";
  });
}
  
  void _handleCityChange(String value) {
    setState(() {
      _package.city = value;
    });
  }
   void _handleDireccionChange(String value) {
    setState(() {
      _package.direccion = value;
    });
  }

  void _handleObservationsChange(String value) {
    setState(() {
      _package.observations = value;
    });
  }



Future<List<Departamento>> fetchDepartamentos() async {
  final response = await http.get(Uri.parse('https://localhost:44356/api/Departamentos/ListarDepartamentos'));
  
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Departamento.fromJson(json)).toList();
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
    });
  } catch (e) {
    print('Error: $e');
  }
}


Future<List<Ciudad>> fetchCiudades(String depa_ID) async {
  final response = await http.get(Uri.parse('https://localhost:44356/api/Departamentos/CiudadesPorDepto?depa_ID=$depa_ID'));
  
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Ciudad.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load ciudades');
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
        title: Text('Registrar paquete'),
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
                ),
                keyboardType: TextInputType.number,
                onChanged: _handleCodeChange,
              ),
             DropdownButtonFormField(
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
             DropdownButton<String>(
  value: _selectedDepartment,
  hint: Text('Seleccione un departamento'),
  items: _departmentList.map((Departamento departamento) {
    return DropdownMenuItem<String>(
      value: departamento.id,
      child: Text(departamento.descripcion),
    );
  }).toList(),
  onChanged: (String? value) async {
    if (value != null) {
      setState(() {
        _selectedDepartment = value;
        _selectedCityList = [];
        _package.city = '';
      });
      List<Ciudad> ciudadList = await fetchCiudades(value);
      setState(() {
        _selectedCityList = ciudadList.map((ciudad) => ciudad.ciud_Descripcion).toList();
      });
    }
  },
),
DropdownButton<String>(
  value: _package.city,
  hint: Text('Seleccione una ciudad'),
  items: _selectedCityList.map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
  onChanged: (String? value) {
    setState(() {
      _package.city = value!;
    });
  },
),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Dirección Exacta',
                ),
                onChanged: _handleDireccionChange,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Observaciones',
                ),
                onChanged: _handleObservationsChange,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _enviarDatos(int.parse(_package.code), int.parse(_package.client),
                                              int.parse(_package.city), _package.direccion, _package.observations, 1),
                child: Text('Registrar paquete'),
              ),
            ],
          ),
        ),
      ),
    );

    
  }

  Future<responseApi> _enviarDatos(int Codigo, int Cliente, int Ciudad, String paqu_DireccionExacta, String Observaciones, int Usuario) async {
      
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
            "paqu_UsuarioCrea": Usuario,
            "paqu_FechaCrea": "2023-04-22T20:31:04.472Z",
            "paqu_UsuarioModifica": 0,
            "paqu_FechaModifica": "2023-04-22T20:31:04.472Z",
            "paqu_Estado": true

        
    };

    String date = jsonEncode(Datos);
   
    try {
     // final response = await http.post(Uri.parse('http://empaquetadora-ecopack.somee.com/api/Envios/Insertar'),
      final response = await http.post(Uri.parse('https://localhost:44356/api/Paquetes/Insertar'),
       
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },  
        body: date);

      if (response.statusCode == 200) {
  
       if (responseApi.fromJson(jsonDecode(response.body)).data != null) {
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

  Future<Map<String, dynamic>> _getClientData() async {
  try {
    final response = await http.get(
      //Uri.parse('http://empaquetadora-ecopack.somee.com/api/Camiones/DDLCamiones'),
          Uri.parse('https://localhost:44356/api/Departamentos/ClientesDDL'),
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

