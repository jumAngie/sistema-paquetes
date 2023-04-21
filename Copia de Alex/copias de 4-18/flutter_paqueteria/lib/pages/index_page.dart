import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String url = "https://api.thecatapi.com/v1/categories";

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

class MyWidget extends StatefulWidget {

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado'),
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
    lista.add(Text(element["name"]));
   });

   return lista;
}