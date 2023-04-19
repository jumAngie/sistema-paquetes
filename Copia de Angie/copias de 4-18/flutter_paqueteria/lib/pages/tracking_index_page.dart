
import 'package:flutter/material.dart';


class DetallePaquetePage extends StatelessWidget {
  final String codigo;

  const DetallePaquetePage({Key? key, required this.codigo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del paquete $codigo'),
      ),
      body: Center(
        child:  
         Text('Aquí puedes mostrar los detalles del paquete con código $codigo'),
         
      ),
    );
  }
}
