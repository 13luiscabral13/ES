
import 'dart:convert';

import 'package:intl/intl.dart';

class EventosModel {
  static const String id = 'id';
  static const String nome = 'nome';
  static const String date = 'date';
  static const String time = 'time';
  static const String descricao = 'descricao';
  static const String gid = 'gid';

  static List<String> getFields() => [id, nome, date, time, descricao, gid];
}

class Evento{
  final int id;
  final String nome;
  final String date;
  final String time;
  final String descricao;
  final String gid;

  const Evento({
    this.id,
    this.nome,
    this.date,
    this.time,
    this.descricao,
    this.gid
  });

  static Evento fromJson(Map<String, dynamic> json) => Evento(
    id: jsonDecode(json[EventosModel.id]),
    nome: json[EventosModel.nome],
    date: json[EventosModel.date],
    time: json[EventosModel.time],
    descricao: json[EventosModel.descricao],
    gid: json[EventosModel.gid],
  );

  Map<String, dynamic> toJson() => {
    EventosModel.id: id,
    EventosModel.nome: nome,
    EventosModel.date: date,
    EventosModel.time: time,
    EventosModel.descricao: descricao,
    EventosModel.gid: gid,
  };
}