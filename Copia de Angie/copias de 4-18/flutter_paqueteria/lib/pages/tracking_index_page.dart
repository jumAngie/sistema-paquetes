
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class DetallePaquetePage extends StatelessWidget {
  final String codigo;

  const DetallePaquetePage({Key? key, required this.codigo}) : super(key: key);

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
            title: Center(child: Text('Detalle del paquete $codigo',
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
        child:  
         Image.asset("/images/bodega-circulo.png", height: 100, width: 100,)
      ),
    );
  }
}
