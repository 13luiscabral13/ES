
import 'dart:convert';

class InvitesModel {
  static const String id = 'id';
  static const String nome = 'nome';
  static const String texto = 'texto';
  static const String tipo = 'tipo';
  static const String codigo = 'codigo';

  static List<String> getFields() => [id, nome, texto, tipo];

  InvitesModel();
}

/* to display each Invite */
class Invite {
  final int id;
  final String nome;
  final String texto;
  final String tipo;
  final String codigo;

  const Invite({
    this.id,
    this.nome,
    this.texto,
    this.tipo,
    this.codigo,
  });

  static Invite fromJson(Map<String, dynamic> json) => Invite(
      id: jsonDecode(json[InvitesModel.id]),
      nome: json[InvitesModel.nome],
      texto: json[InvitesModel.texto],
      tipo: json[InvitesModel.tipo],
      codigo: json[InvitesModel.codigo],
  );


  Map<String, dynamic> toJson() => {
    InvitesModel.id: id,
    InvitesModel.nome: nome,
    InvitesModel.texto: texto,
    InvitesModel.tipo: tipo,
    InvitesModel.codigo: codigo,
  };
}
