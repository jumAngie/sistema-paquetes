// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_paqueteria/util/iconos_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[600],
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
      ],
      ),
      body: SafeArea(
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
                  '¡ Bienvenido a EcoPack™ !',
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
                IconoMenu(
                  icono: '📦',
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
                IconoMenu(
                  icono: '🚛',
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
                IconoMenu(
                  icono: '📩',
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
                    height: 10,
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
                          ),
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
                          subtitle: Text('Nuestra visión es liderar el camino hacia un futuro más sostenible y consciente del medio ambiente. Queremos ser reconocidos como la opción preferida para aquellos que buscan una alternativa ecológica y responsable en el envío y la entrega de paquetes.',
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