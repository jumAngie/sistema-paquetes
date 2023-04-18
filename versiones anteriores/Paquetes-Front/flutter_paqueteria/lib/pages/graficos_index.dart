// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_paqueteria/navigation/bottomnavigation.dart';

class Graficos extends StatelessWidget {
  const Graficos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: BNavigator(),
        body: Center(child: Text('Graficos')),
    );
  }
}