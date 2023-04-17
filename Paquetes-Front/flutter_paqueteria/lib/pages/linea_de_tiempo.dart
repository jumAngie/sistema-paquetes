// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class VerPaquetePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver paquete'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_shipping, size: 100),
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

