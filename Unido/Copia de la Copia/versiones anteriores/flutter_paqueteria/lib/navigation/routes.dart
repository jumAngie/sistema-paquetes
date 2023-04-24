import 'package:flutter/material.dart';
import 'package:flutter_paqueteria/pages/usuario_perfil_page.dart';
import 'package:flutter_paqueteria/pages/home_page.dart';
import 'package:flutter_paqueteria/pages/graficos_index.dart';

class Routes extends StatelessWidget {
  final int index;
  const Routes({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [

      const HomePage(),
      const Profile(),
      const Graficos()
      

    ];
    return myList[index];
  }
}