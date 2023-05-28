import 'dart:convert';
import 'package:flutter/material.dart';

class AmizadeModel {
  static const String id = 'id';
  static const String uid1 = 'uid1';
  static const String uid2 = 'uid2';

  static List<String> getFields() => [id, uid1, uid2,];

}

/* to display each Friend */
class Amizade {
  final int id;
  final String uid1;
  final String uid2;

  const Amizade({
    this.id,
    @required this.uid1,
    @required this.uid2,
  });

  static Amizade fromJson(Map<String, dynamic> json) => Amizade(
    id: jsonDecode(json[AmizadeModel.id]),
    uid1: json[AmizadeModel.uid1],
    uid2: json[AmizadeModel.uid2],
  );

  Map<String, dynamic> toJson() => {
    AmizadeModel.id: id,
    AmizadeModel.uid1: uid1,
    AmizadeModel.uid2: uid2,
  };
}
