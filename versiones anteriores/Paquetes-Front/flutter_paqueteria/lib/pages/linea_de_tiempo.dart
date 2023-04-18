// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class VerPaquetePage extends StatelessWidget {
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
            title: Center(child: Text("Buscar Paquete",
                                      style: TextStyle(
                                        fontWeight: 
                                        FontWeight.bold),
                                        )
                                        ),
            backgroundColor: Colors.green[400],
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/opcion.gif', height: 150),
            SizedBox(height: 20),
            Text('Ingrese el código para ver el paquete', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Container(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Código del paquete',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
