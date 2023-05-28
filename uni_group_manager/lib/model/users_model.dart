

import 'dart:convert';

import 'package:flutter/material.dart';

class Users{
  static const String id = 'id';
  static const String codigo = 'codigo';
  static const String nome = 'nome';
  static const String descricao = 'descricao';

  static List<String> getFields() => [id, codigo, nome, descricao,];
}

class User{
  final int id;
  final String codigo;
  final String nome;
  final String descricao;

  const User({
    this.id,
    @required this.codigo,
    @required this.nome,
    @required this.descricao
  });

  static User fromJson(Map<String, dynamic> json) => User(
    id: jsonDecode(json[Users.id]),
    codigo: json[Users.codigo],
    nome: json[Users.nome],
    descricao: json[Users.descricao],
  );

  Map<String, dynamic> toJson() => {
    Users.id: id,
    Users.codigo: codigo,
    Users.nome: nome,
    Users.descricao: descricao
  };
}
