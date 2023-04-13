// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_paqueteria/navigation/bottomnavigation.dart';

class ListadoPaquetes extends StatelessWidget {
  const ListadoPaquetes({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: BNavigator(),
       body: Center(child: Text('Paquetes')),
    );
  }
}