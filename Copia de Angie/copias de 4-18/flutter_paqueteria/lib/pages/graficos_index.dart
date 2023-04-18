// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_paqueteria/navigation/bottomnavigation.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

String url = "http://empaquetadora-ecopack.somee.com/api/EnviosPorPaquete/Grafico";

Future<dynamic> _getListado() async{
  final respuesta = await http.get(Uri.parse(url));
  if(respuesta.statusCode == 200)
  {
    final json = respuesta.body;
    return jsonDecode(json);
  }
  else
  {
    print("Error con la respuesta");
  }
}

class Graficos extends StatefulWidget {
  const Graficos({Key? key}) : super(key: key);

  @override
  State<Graficos> createState() => _GraficosState();
}

class _GraficosState extends State<Graficos> {
  Future<dynamic>? _futureListado;

  @override
  void initState() {
    super.initState();
    _futureListado = _getListado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BNavigator(),
      appBar: AppBar(
          shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
          ),
          ),
            title: Center(
                          ),
            leading: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                        Navigator.pop(context);
                                              },
                                              ),
            backgroundColor: Colors.green[400],
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
                child: Image.asset(
                  'images/Logo02.png', height: 90),
            ),
            SizedBox(
              height: 5,
            ),
            Center(child:
                Text(
                              'Cantidad de paquetes por Clientes',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: FutureBuilder<dynamic>(
                future: _futureListado,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> info = snapshot.data as List<dynamic>;
                    final List<ChartData> data = info.map((element) => ChartData(element['cliente'], element['cantidad'])).toList();

                    final series = [
                      charts.Series(
                        id: 'Valores',
                        data: data,
                        domainFn: (ChartData values, _) => values.cliente,
                        measureFn: (ChartData values, _) => values.cantidad,
                      ),
                    ];

                    return charts.BarChart(
                      series,
                      animate: true,
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final String cliente;
  final int cantidad;

  ChartData(this.cliente, this.cantidad);
}

