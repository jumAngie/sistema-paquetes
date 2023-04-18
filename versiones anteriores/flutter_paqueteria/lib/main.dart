// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_paqueteria/pages/envios_index_page.dart';
import 'package:flutter_paqueteria/pages/home_page.dart';
import 'package:flutter_paqueteria/pages/index_page.dart';
import 'package:flutter_paqueteria/pages/login_page.dart';
import 'package:flutter_paqueteria/pages/usuarios_index_page.dart';
import 'package:flutter_paqueteria/pages/paquetes_index_page.dart';
import 'package:flutter_paqueteria/pages/tracking_index_page.dart';
import 'package:flutter_paqueteria/pages/usuario_perfil_page.dart';

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
      initialRoute: LoginPage.id,
      routes: {
           LoginPage.id : (context)  => LoginPage(),

        'home': ( _ ) => ListadoUsuarios(),
        'envios_index_page': ( _ ) =>  ListadoEnvios(),
        'paquetes_index_page': ( _ ) => ListadoPaquetes(),
        'tracking_index_page': ( _ ) => Tracking(),
        'profile_index_page': ( _ ) => Profile()
      }
      
    );
  }
}