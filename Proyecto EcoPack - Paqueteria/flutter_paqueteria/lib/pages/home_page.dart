// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';
import 'package:flutter_paqueteria/util/iconos_menu.dart';
import 'package:flutter_paqueteria/navigation/bottomnavigation.dart';
import 'package:flutter_paqueteria/pages/paquetes_index_page.dart';
import 'package:flutter_paqueteria/pages/linea_de_tiempo.dart';
import 'package:flutter_paqueteria/pages/ejemplo.dart';
import 'package:flutter_paqueteria/pages/login_index.dart';

import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  
}

extension StringExtension on String {
  String get capitalizeFirst2 {
    if (this.isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}


class _HomePageState extends State<HomePage> {
  int index = 0;
  final DateFormat formatterLetra = DateFormat('EEEE, dd MMMM yyyy', 'ES');
  
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
                formatterLetra.format(DateTime.now()).capitalizeFirst2,
                style: TextStyle(color: Colors.green[200]),
                ),

                ],
              ),
            
                      // Icono de Notificacion
                      Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Color.fromARGB(255, 155, 233, 117), Color.fromARGB(255, 114, 200, 88), Color.fromARGB(255, 85, 253, 90)],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: EdgeInsets.all(12),
                                      child: GestureDetector(
                                          onTap: (){Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPageIndex()),
                    );
                                            }, 
                                            child: Icon(
                                              Icons.logout,
                                              color: Colors.white,
                                        ),
                          ),
                      ),
                    ],
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListadoPaquetes()),
                    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerPaquetePage()),
                    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListadoEnvios()),
                    );
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
                          title: Text(
                            'Misión',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          subtitle: Text('Nuestra misión es ofrecer soluciones de envío y entrega ecológicas y responsables, protegiendo el medio ambiente y fomentando la sostenibilidad.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
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
                          title: Text(
                            'Visión',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          subtitle: Text('Nuestra visión es liderar el camino hacia un futuro más sostenible y consciente del medio ambiente.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
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