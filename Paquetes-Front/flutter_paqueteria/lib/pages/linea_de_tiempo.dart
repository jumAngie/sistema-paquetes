import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EstadoPaquete {
  final String estado;
  final DateTime fecha;

  EstadoPaquete({required this.estado, required this.fecha});
}

List<EstadoPaquete> estadosPaquete = [
  EstadoPaquete(estado: 'Bodega', fecha: DateTime(2023, 4, 1)),
  EstadoPaquete(estado: 'En Camino', fecha: DateTime(2023, 4, 5)),
  EstadoPaquete(estado: 'Entregado', fecha: DateTime(2023, 4, 10)),
];

