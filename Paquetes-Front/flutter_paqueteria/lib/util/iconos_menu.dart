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
              color: Colors.green[400],
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