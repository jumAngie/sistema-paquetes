// ignore_for_file: prefer_const_constructors, empty_constructor_bodies

import 'package:flutter/material.dart';

class IconoMenu extends StatelessWidget {

  final String icono;

  const IconoMenu({
    Key? key,
    required this.icono,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromARGB(255, 155, 233, 117), Color.fromARGB(255, 114, 200, 88), Color.fromARGB(255, 85, 253, 90)],
                                  ),
              borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(12),
              child: 
               Center(
                child: 
                Text(
                    icono,
                    style: TextStyle(
                    fontSize: 28
                    )
               ),)
            );
  }
}