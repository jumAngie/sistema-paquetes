// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_paqueteria/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paqueteria/navigation/bottomnavigation.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_paqueteria/util/responseApi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_paqueteria/util/usuarios.dart';

Future<Map<String, dynamic>> fetchUserData() async {
  try {
    int ID = await SessionManager().get("Persona");

    final response = await http
        .post(Uri.parse('https://localhost:44356/api/Usuarios/personas/$ID'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      
      
      return {
        "pers_Id": data['pers_Id'],
        "pers_Nombres": data['pers_Nombres'],
        "pers_Apellidos": data['pers_Apellidos'],
        "pers_DNI": data['pers_DNI'],
        "pers_Sexo": data['pers_Sexo'],
        "esci_Descripcion": data['esci_Descripcion']
      };

      
    } else {
      throw Exception('Failed to load user data');
    }
  } catch (e) {
    throw Exception(e);
  }
}



class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  _ProfileState createState() => _ProfileState();
  
}

class _ProfileState extends State<Profile> {
  Future<dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _userData = fetchUserData();
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
          title: Center(
            child: Text('Perfil',
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
            backgroundColor: Colors.green,
        ),
        body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 15,
              left: 0,
              right: 0,
              child: ClipOval(
                child: Image.asset(
                  'images/jeje.jpg',
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                ),
              ),
            ),

          Card(
            margin: EdgeInsets.only(top: 199, left: 16, right: 16, bottom: 100),
            color: Color.fromARGB(255, 236, 236, 236),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SizedBox(
              width: 280, // Cambie el valor para ajustar el ancho deseado
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FutureBuilder<dynamic>(
                        future: _userData,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            dynamic userData = snapshot.data;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Nombre completo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '${userData['pers_Nombres']} ${userData['pers_Apellidos']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 16),

                                Text(
                                  'DNI',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '${userData['pers_DNI']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 16),

                                
                                Text(
                                  'Sexo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                
                                Text(
                                  
                                  '${userData['pers_Sexo']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Estado Civil',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '${userData['esci_Descripcion']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 32),
                                Column(
                                  children: [
                                 ElevatedButton.icon(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      icon: Icon(Icons.exit_to_app),
      label: Text('Cerrar Sesión'),
      style: ElevatedButton.styleFrom(
        primary: Colors.green[500],
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
      ),
    ),
    SizedBox(height: 13),
    ElevatedButton.icon(
      onPressed: () {
        mostrarDialogo();
      },
      icon: Icon(Icons.lock),
      label: Text('Cambiar Contraseña'),
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 255, 0, 0),
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
      ),
    ),
                              ],
                              
                                ),
                              ]
                            );
                              
                          } else if (snapshot.hasError) {
                            return Text(
                                "Ha ocurrido un error al cargar los datos del usuario.");
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ])));
  }


mostrarDialogo() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Cambiar Contraseña"),
        content: TextField(
          obscureText: true,
          decoration: InputDecoration(hintText: "Nueva Clave"),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
            primary: Colors.green[500]),
            onPressed: () {
              // Aquí va la lógica para confirmar
            },
            child: Text("Confirmar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 255, 0, 0)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancelar"),
          ),
        ],
      );
    },
  );
}


}


Future<responseApi> CambiarContrasena(BuildContext context,int usua_Id, int pers_Id,String usua_Usuario,
      String usua_Clave, int usua_Empleado, String pers_Nombres) async {
      
      Map<String, dynamic> DatosUser = {
          'usua_Id': usua_Id.toString(),
          'pers_Id': pers_Id.toString(),
          'usua_Usuario': usua_Usuario,
          'usua_Clave': usua_Clave,
          'usua_Empleado': usua_Empleado.toString(),
          'pers_Nombres': pers_Nombres
    
    };

    String date = jsonEncode(DatosUser);
   
    try {
     // final response = await http.post(Uri.parse('http://empaquetadora-ecopack.somee.com/api/Envios/Insertar'),
      final response = await http.post(Uri.parse('https://localhost:44356/api/Envios/Cambiar'),
       
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },  
        body: date);

      if (response.statusCode == 200) {
  
       if (responseApi.fromJson(jsonDecode(response.body)).data != null) {
  Fluttertoast.showToast(
    msg: "Cambio de Contraseña exitosamente",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 4, 
    backgroundColor: Colors.blueAccent,
    textColor: Colors.white,
    fontSize: 16.0,
 
  );
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
    
      } return new responseApi(
          code: 0, 
          success: false, 
          message: "Nada", 
          data: new Usuario(
                    usua_Id: usua_Id, 
                    pers_Id: pers_Id,
                    usua_Usuario: usua_Usuario, 
                    usua_Clave: usua_Clave, 
                    usua_Empleado: usua_Empleado, 
                    pers_Nombres: 
                    pers_Nombres)
        );
    } catch (e) {
      throw Exception(e);
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

