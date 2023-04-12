import 'package:flutter/material.dart';

import 'package:flutter_paqueteria/pages/home_page.dart';
import 'package:flutter_paqueteria/pages/index_page.dart';
import 'package:flutter_paqueteria/pages/usuarios_index_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListadoUsuarios(),
      
    );
  }
}