
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_paqueteria/navigation/bottomnavigation.dart';

class DetallePaquetePage extends StatelessWidget {
  final String codigo;

  const DetallePaquetePage({Key? key, required this.codigo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BNavigator(),
      appBar: AppBar(
          shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
          ),
          ),
            title: Center(child: Text('Estado del paquete #$codigo',
                                      style: TextStyle(
                                        fontWeight: 
                                        FontWeight.bold),
                                        )
                                        ),
            leading: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                        Navigator.pop(context);
                                              },
                                              ),
            backgroundColor: Colors.green[400],
        ),
      body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
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
          "Fecha: 20/04/2023",
          style: TextStyle(color: Color.fromARGB(255, 36, 36, 36)),
        ),
      ],
    ), // un espacio en blanco de 16 píxeles
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
          "Pendiente",
          style: TextStyle(color: Color.fromARGB(255, 36, 36, 36)),
        ),
      ],
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
          "Pendiente",
          
          style: TextStyle(color: Color.fromARGB(255, 36, 36, 36)),
        ),
      ],
     ), 
    ],
  ),
),
    );
  }
}
