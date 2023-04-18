
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:flutter_paqueteria/util/ResponseApi.dart';
import 'package:flutter_paqueteria/util/usuarios.dart';
import 'package:flutter_paqueteria/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  static String id = 'loginpage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usuario = TextEditingController();
  final TextEditingController clave = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              color: Colors.grey[300],
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'images/300.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                  top: 20.0,
                  right: 20.0,
                  child: SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: Image.asset('images/Logo02.png'),
                  ),
                ),
                  Center(
                    child: Container(
                      width: constraints.maxWidth * 0.8,
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                       
                          SizedBox(height: 20.0),
                          _usuarioTextField(),
                          SizedBox(height: 20.0),
                          _buttonlogin(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _usuarioTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                child: TextFormField(
                  controller: usuario,
                  validator: _validateRequired,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    icon: Icon(Icons.text_fields),
                    hintText: 'Nombre de Usuario',
                    labelText: 'Usuario',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                child: TextFormField(
                  controller: clave,
                  validator: _validateRequired,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Clave de Usuario',
                    labelText: 'Clave',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buttonlogin() {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text(
            'Ingresar',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 18.8,
          primary: Colors.green,
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ValidarLogin(0, usuario.text, clave.text, 0, "");
          }
        },
      );
    },
  );
}
  
  
  void showToast() {
    FToast fToast;
    fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            "El nombre de usuario y/o\ncontraseña es incorrecto",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  Future<responseApi> ValidarLogin(int usua_Id, String usua_Usuario,
      String usua_Clave, int usua_Empleado, String pers_Nombres) async {

    try {
      final response = await http.post(
        Uri.parse('http://empaquetadora-ecopack.somee.com/api/Usuarios/Login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'usua_Id': usua_Id.toString(),
          'usua_Usuario': usua_Usuario,
          'usua_Clave': usua_Clave,
          'usua_Empleado': usua_Empleado.toString(),
          'pers_Nombres': pers_Nombres
        }),
      );

      if (response.statusCode == 200) {

   
        if(responseApi.fromJson(jsonDecode(response.body)).data != null){
           
          Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => HomePage() ));
          
           return responseApi.fromJson(jsonDecode(response.body)    );
        }else{
          showToast();
        }
       
      } else {
        showToast();
      }
        return new responseApi(
          code: 0, 
          success: false, 
          message: "Nada", 
          data: new Usuario(
                    usua_Id: usua_Id, 
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

 void _save() {
    if (_formKey.currentState!.validate()) {
      ValidarLogin(0, usuario.text, clave.text, 0, "");
    } 
  }

  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) return 'El campo es requerido';
    return null;
  }


}




