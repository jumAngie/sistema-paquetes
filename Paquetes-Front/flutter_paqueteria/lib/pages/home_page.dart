// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_paqueteria/util/iconos_menu.dart';
import 'package:flutter_paqueteria/navigation/bottomnavigation.dart';
import 'package:flutter_paqueteria/navigation/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[600],
      bottomNavigationBar: BNavigator(),
      body:
      SafeArea(
        child: 
        Column(
          children: [
            // Fila de Saludos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: 
              Column(
                children: [
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                      // ¡Bienvenido!
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                  '¡Bienvenido a EcoPack™!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  SizedBox(
                    height: 5,
                    ),
                  Text(
                    '12 Abril, 2023',
                    style: TextStyle(color: Colors.green[200]),
                  ),
                ],
              ),
            
                      // Icono de Notificacion
                      Container(
              decoration: BoxDecoration(
              color: Colors.green[400],
              borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
                      ) 
                    ],
                    ),
            
                    SizedBox(
                      height: 20,
                    ),
                    // Barra de Búsqueda
                    Container(
                      decoration: BoxDecoration(
              color: Colors.green[400],
              borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(12),
                      child: 
                      Row(children: 
                      [
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              SizedBox(
               width: 10,
              ),
              Text(
                'Buscar...',
                style: TextStyle(
                color: Colors.white),
              ),
              
                      ],
                    ),
                    ),
            
            
                    SizedBox(
                      height: 20,
                    ),
            
                    // Iconos
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
               Text(
                      'General',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
              Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
                       ],
                     ),
            
                     SizedBox(
                      height: 20,
                     ),
            
                     // Fila de Iconos
                     Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      // Icono de Paquetes
                      Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, 'paquetes_index_page');
                  },
                  child: IconoMenu(
                    icono: '📦',
                  ),
                ),
                SizedBox(
                  height: 5,
                      ),
                Text(
                  'Paquetes',
                  style: TextStyle(color: Colors.white),
                      )
              ],
                      ),
                      // Icono de Tracking
                      Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'tracking_index_page');
                  },
                  child: IconoMenu(
                    icono: '🚛',
                  ),
                ),
                SizedBox(
                  height: 5,
                      ),
                Text(
                  'Rastreo',
                  style: TextStyle(color: Colors.white),
                      )
              ],
                      ),
                      // Icono de Ajustes
                      Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'envios_index_page');
                  },
                  child: IconoMenu(
                    icono: '📩',
                  ),
                ),
                SizedBox(
                  height: 5,
                      ),
                Text(
                  'Envios',
                  style: TextStyle(color: Colors.white),
                      )
              ],
                      ),
                     ],
                     ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
        Expanded(
              child: 
              Container(
                padding: EdgeInsets.all(25),
                color: Colors.grey[100],
                child: Center(
                  child: Column(
                    children: [
                      // Heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Objetivos de EcoPack',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.more_horiz)
                      ],
                    ),

                  SizedBox(
                    height: 15,
                  ),


                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 238, 238, 238),
                        borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.check_circle_outline,
                          color: Colors.green),
                          title: Text('Misión'),
                          subtitle: Text('Nuestra misión es ofrecer soluciones de envío y entrega ecológicas y responsables, protegiendo el medio ambiente y fomentando la sostenibilidad.',
                          textAlign: TextAlign.justify,
                          )
                          ),
                    ),
                    
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 238, 238, 238),
                        borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.remove_red_eye_rounded,
                          color: Colors.green),
                          title: Text('Visión'),
                          subtitle: Text('Nuestra visión es liderar el camino hacia un futuro más sostenible y consciente del medio ambiente.',
                          textAlign: TextAlign.justify,
                          ),
                          ),
                    )
                  ],),
                )
                ),
                ),
         
            ],
            ),
      ),
    );
  }
}