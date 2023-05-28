
import 'dart:convert';

class GruposModel {
  static const String id = 'id';
  static const String nome = 'nome';
  static const String descricao = 'descricao';

  static List<String> getFields() => [id, nome, descricao,];

}

/* to display each Friend */
class Grupo {
  final int id;
  final String nome;
  final String descricao;

  const Grupo({
    this.id,
    this.nome,
    this.descricao,
  });

  static Grupo fromJson(Map<String, dynamic> json) => Grupo(
    id: jsonDecode(json[GruposModel.id]),
    nome: json[GruposModel.nome],
    descricao: json[GruposModel.descricao],
  );

  Map<String, dynamic> toJson() => {
    GruposModel.id: id,
    GruposModel.nome: nome,
    GruposModel.descricao: descricao,
  };
}
