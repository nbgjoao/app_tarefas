import 'package:flutter/material.dart';

class Tarefa {
  String? id;
  String? tarefaTexto;
  bool feito;

  Tarefa({
    required this.id,
    required this.tarefaTexto,
    this.feito = false,
  });

  static List<Tarefa> tarefaList() {
    return [
      Tarefa(id: '01', tarefaTexto: 'Academia', feito: true),
      Tarefa(id: '02', tarefaTexto: 'Ir ao mercado', feito: true),
      Tarefa(id: '03', tarefaTexto: 'Responder e-mails'),
      Tarefa(id: '04', tarefaTexto: 'Reunião'),
      Tarefa(id: '05', tarefaTexto: 'Estudar'),
      Tarefa(id: '06', tarefaTexto: 'Passear com o cachorro'),
    ];
  }
}