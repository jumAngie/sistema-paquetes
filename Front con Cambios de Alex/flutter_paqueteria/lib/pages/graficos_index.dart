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


class Graficos extends StatelessWidget {
 const Graficos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BNavigator(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gráfico de barras'),
            SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: FutureBuilder<dynamic>(
                future: _getListado(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    final List<dynamic> data = snapshot.data;
                    return _buildBarChart(data);
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart(List<dynamic> data) {
    final series = charts.Series.fromList(
      data,
      id: 'Valores',
      domainFn: (dynamic values, _) => values['cliente'] as String,
      measureFn: (dynamic values, _) => values['cantidad'] as int,
    );

    return charts.BarChart(
      [series],
      animate: true,
    );
  }
}
