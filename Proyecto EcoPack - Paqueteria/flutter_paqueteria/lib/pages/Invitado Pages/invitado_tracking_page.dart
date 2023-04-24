// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


class IDetallePaquetePage extends StatefulWidget {
  final String codigo;

  

  const IDetallePaquetePage({Key? key, required this.codigo}) : super(key: key);

  @override
  _IDetallePaquetePageState createState() => _IDetallePaquetePageState();
}

extension StringExtension on String {
  String get capitalizeFirst {
    if (this.isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}


class NoSuchPackageException implements Exception {}

class Paquete {
  final int paqu_Id;
  final int paqu_Codigo;
  final int paqu_Cliente;
  final int paqu_Ciudad;
  final String depa_Descri;
  final String ciud_Descri;
  final String cliente;
  final String paqu_DireccionExacta;
  final String paqu_Observaciones;
  final DateTime paqu_Bodega;
  final DateTime paqu_EnCamino;
  final DateTime paqu_Entregado;
  final int paqu_UsuarioCrea;
  final DateTime paqu_FechaCrea;
  final int paqu_UsuarioModifica;
  final DateTime paqu_FechaModifica;
  final bool paqu_Estado;
  final String estado;

  Paquete({
    required this.paqu_Id,
    required this.paqu_Codigo,
    required this.paqu_Cliente,
    required this.paqu_Ciudad,
    required this.depa_Descri,
    required this.ciud_Descri,
    required this.cliente,
    required this.paqu_DireccionExacta,
    required this.paqu_Observaciones,
    required this.paqu_Bodega,
    required this.paqu_EnCamino,
    required this.paqu_Entregado,
    required this.paqu_UsuarioCrea,
    required this.paqu_FechaCrea,
    required this.paqu_UsuarioModifica,
    required this.paqu_FechaModifica,
    required this.paqu_Estado,
    required this.estado,
  });

  factory Paquete.fromJson(Map<String, dynamic> json) {
    return Paquete(
      paqu_Id: json['paqu_Id'],
      paqu_Codigo: json['paqu_Codigo'],
      paqu_Cliente: json['paqu_Cliente'],
      paqu_Ciudad: json['paqu_Ciudad'],
      depa_Descri: json['depa_Descri'],
      ciud_Descri: json['ciud_Descri'],
      cliente: json['cliente'],
      paqu_DireccionExacta: json['paqu_DireccionExacta'],
      paqu_Observaciones: json['paqu_Observaciones'],
      paqu_Bodega: DateTime.parse(json['paqu_Bodega']),
      paqu_EnCamino: DateTime.parse(json['paqu_EnCamino']),
      paqu_Entregado: DateTime.parse(json['paqu_Entregado']),
      paqu_UsuarioCrea: json['paqu_UsuarioCrea'],
      paqu_FechaCrea: DateTime.parse(json['paqu_FechaCrea']),
      paqu_UsuarioModifica: json['paqu_UsuarioModifica'],
      paqu_FechaModifica: DateTime.parse(json['paqu_FechaModifica']),
      paqu_Estado: json['paqu_Estado'],
      estado: json['estado'],
    );
  }
}

Future<List<Map<String, dynamic>>> getPaquete(int codigo) async {
  final response = await http.get(Uri.parse('http://ecopack.somee.com/api/Paquetes/PaquetesPorCodigo/$codigo'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List<dynamic>;
    return data.map((value) => value as Map<String, dynamic>).toList();
  } else {
    throw Exception('Failed to load paquete');
  }
}



class _IDetallePaquetePageState extends State<IDetallePaquetePage> {
     late Future<List<Map<String, dynamic>>> paquete;
     final DateFormat formatter = DateFormat('dd-MM-yyyy');
     final DateFormat formatterLetra = DateFormat('EEEE, dd MMMM yyyy', 'ES');




   @override
  void initState() {
    super.initState();
    paquete = getPaquete(int.parse(widget.codigo));
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
          shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
          ),
          ),
            title: Text('Paquete #${widget.codigo}',
                                      style: TextStyle(
                                        fontWeight: 
                                        FontWeight.bold,
                                        fontSize: 30),
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
       FutureBuilder<List<Map<String, dynamic>>>(
        future: paquete,
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final paqueteData = snapshot.data!.first;
            if(paqueteData.isNotEmpty)
            {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 15,),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 20, color: Colors.lightGreen),
            
                                children: [
                                  TextSpan(text: 'Estado del paquete: '),
                                  TextSpan(
                                    text: '${paqueteData['estado']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Color.fromARGB(255, 2, 124, 29),
                                      fontSize: 20 // color del highlight
                                    ),
                                ),
                              ],
                            ),
                          ),
                SizedBox(
                  height: 24,
                ),
        Image.asset("/images/bodega-circulo.png", height: 100, width: 100,),
        SizedBox(width: 10), // espacio entre la imagen y el texto
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "En Bodega",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
             "Fecha: ${paqueteData['paqu_Bodega'] != null ? formatterLetra.format(DateTime.parse(paqueteData['paqu_Bodega'])) : 'Pendiente'}",
            style: TextStyle(color: Color.fromARGB(255, 36, 36, 36)),
          ),
        ],
      ), 
      SizedBox(
        height: 13,
       ),// un espacio en blanco de 16 píxeles
        Image.asset("/images/encamino-circul.png", height: 100, width: 100,),
        SizedBox(width: 10), // espacio entre la imagen y el texto
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "En Camino",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
           "Fecha: ${paqueteData['paqu_EnCamino'] != null ? formatterLetra.format(DateTime.parse(paqueteData['paqu_EnCamino'])) : 'Pendiente'}",
            style: TextStyle(color: Color.fromARGB(255, 36, 36, 36)),
          ),
        ],
       ),
       SizedBox(
        height: 13,
       ), // un espacio en blanco de 16 píxeles
        Image.asset("/images/entregado-circulo.png", height: 100, width: 100,),
        SizedBox(width: 10), // espacio entre la imagen y el texto
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Entregado",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(  
           "Fecha: ${paqueteData['paqu_Entregado'] != null ? formatterLetra.format(DateTime.parse(paqueteData['paqu_Entregado'])) : 'Pendiente'}",
            
            style: TextStyle(color: Color.fromARGB(255, 36, 36, 36)),
          ),
        ],
       ), 
       SizedBox(
          height: 20,
        ),
      ],
    ),
  ),
);
            }
            else
            {
                return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image.asset('images/200w-unscreen.gif', height: 150),
              SizedBox(height: 16),
              Text(
                'El Código que digitaste no coincide con ningún paquete.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
            }
          } else if (snapshot.hasError)
          {
            return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/200w-unscreen.gif', height: 150),
                SizedBox(height: 16),
                Text(
                  'El Código que digitaste no coincide con ningún paquete.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
          } 
          else{
            return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/200w-unscreen.gif', height: 150),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'El Código que digitaste no coincide con ningún paquete.',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
          }
          }
        )
      );
    }
  }