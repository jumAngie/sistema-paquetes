import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String url = "http://empaquetadora-ecopack.somee.com/api/Usuarios/List";

Future<dynamic> _getListado() async{
  final respuesta = await http.get(Uri.parse(url));
  if(respuesta.statusCode == 200)
  {
    final json = respuesta.body;
    return jsonDecode(json);
  }
  else
  {
    print("Error con la respuesta");
  }
}


class ListadoUsuarios extends StatefulWidget {

  @override
  State<ListadoUsuarios> createState() => _ListadoUsuariosState();
}

class _ListadoUsuariosState extends State<ListadoUsuarios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Usuarios'),
        ),
        body: FutureBuilder<dynamic>(
          future: _getListado(),
          builder: (context, item){
            if(item.hasData){
            return ListView(
                children: listado(item.data),
              );
            }
            else
            {
              return Text('Sin Data');
            }
          }
    ),
    );
  }
}

List<Widget> listado(List<dynamic> info){
  List<Widget> lista = [];
  info.forEach((element) { 
    lista.add(Text(element["usua_Id"] + ' ' + element["usua_Usuario"] + ' ' + element['es_Admin']));
   });

   return lista;
}