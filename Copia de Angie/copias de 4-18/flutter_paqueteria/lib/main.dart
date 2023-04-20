// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_paqueteria/pages/home_page.dart';
import 'package:flutter_paqueteria/pages/login_page.dart';
import 'package:flutter_paqueteria/pages/paquetes_index_page.dart';
import 'package:flutter_paqueteria/pages/tracking_index_page.dart';
import 'package:flutter_paqueteria/pages/usuario_perfil_page.dart';
import 'package:flutter_paqueteria/pages/ejemplo.dart';
import 'package:flutter_paqueteria/pages/linea_de_tiempo.dart';

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
      title: 'Paquetería EcoPack',
      initialRoute: 'home',
      routes: {
           LoginPage.id : (context)  => LoginPage(),
            'home': ( _ ) => HomePage(),

        'Listado': ( _ ) => ListadoEnvios(),
        'envios_index_page': ( _ ) =>  ListadoEnvios(),
        'paquetes_index_page': ( _ ) => ListadoPaquetes(),
        'tracking_index_page': ( _ ) => VerPaquetePage(),
        'profile_index_page': ( _ ) => Profile(),
        'login_page': ( _ ) => LoginPage(),
        '/detallePaquete': (context) {
                                  final codigo = ModalRoute.of(context)!.settings.arguments as String;
                                  return DetallePaquetePage(codigo: codigo);},

      }
      
    );
  }
}