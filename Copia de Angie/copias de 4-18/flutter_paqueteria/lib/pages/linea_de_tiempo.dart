// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_paqueteria/navigation/bottomnavigation.dart';

class VerPaquetePage extends StatelessWidget {
  final _codigoController = TextEditingController(); // controlador para obtener el valor del TextField

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
        title: Center(
          child: Text(
            "Buscar Paquete",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.green[400],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/paquete-unscreen.gif', height: 150),
            SizedBox(height: 20),
            Text('Ingrese el código para ver el paquete', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Container(
              width: 200,
              child: TextField(
                controller: _codigoController, // Asigna el controlador al TextField
                decoration: InputDecoration(
                  hintText: 'Código del paquete',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
  onPressed: () {
    final codigo = _codigoController.text; // obtiene el valor del TextField
     _codigoController.clear();
    if (codigo.isEmpty) {
      // muestra un mensaje de error si el campo está vacío
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color.fromARGB(255, 173, 39, 30),
          content: Center(child: Text('Debe ingresar un código.', style:
          TextStyle( 
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold
          )
          )
          ),
        ),
      );
    } else {
      Navigator.pushNamed(context, '/detallePaquete', arguments: codigo);
    }
  },
  child: Text('Buscar'),
  style: ButtonStyle(
    minimumSize: MaterialStateProperty.all(Size(200, 60)), // define el tamaño mínimo del botón
    backgroundColor: MaterialStateProperty.all(Colors.green), // define el color de fondo del botón
    foregroundColor: MaterialStateProperty.all(Colors.white), // define el color del texto del botón
    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)), // define el estilo del texto del botón
  ),
),


          ],
        ),
      ),
    );
  }
}

