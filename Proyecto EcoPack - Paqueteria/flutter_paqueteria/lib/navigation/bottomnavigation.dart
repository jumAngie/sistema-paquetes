import 'package:flutter/material.dart';
import 'package:flutter_paqueteria/pages/graficos_index.dart';
import 'package:flutter_paqueteria/pages/usuario_perfil_page.dart';
import 'package:flutter_paqueteria/pages/home_page.dart';


class BNavigator extends StatefulWidget {
  const BNavigator({super.key});

  @override
  State<BNavigator> createState() => _BNavigatorState();
}

class _BNavigatorState extends State<BNavigator> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        
        iconSize: 25.0,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
      items: [
        BottomNavigationBarItem(
        icon: IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => HomePage())),

         icon: Icon(Icons.home)
         ), 
         label: 'Principal'
         ),
        
         BottomNavigationBarItem(
        icon: IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Profile())),

         icon: Icon(Icons.person)
         ), 
         label: 'Perfil'
         ),
        BottomNavigationBarItem(
        icon: IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Graficos())),

         icon: Icon(Icons.bar_chart)
         ), 
         label: 'Gráficos'
         )
      ]);
  }
}

