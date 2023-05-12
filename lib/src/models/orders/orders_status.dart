import 'package:flutter/material.dart';

enum OrderStatus {
  pedente('Pendente', 'P', Colors.blue),
  confrimado('Confirmado', 'C', Colors.amber),
  finalizado('Finalizado', 'D', Colors.amber),
  cancelado('Cancelado', 'R', Colors.amber);

  final String name;
  final String acronym;
  final Color color;

  const OrderStatus(this.name, this.acronym, this.color);

  static OrderStatus parse(String acronym) {
    return values.firstWhere((s) => s.acronym == acronym);
  }
}
