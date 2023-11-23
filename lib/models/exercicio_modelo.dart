class ExercicioModelo {
  String id;
  String name;
  String treino;
  String comoFazer;
  String? urlImagem;

  ExercicioModelo({
    required this.id,
    required this.name,
    required this.treino,
    required this.comoFazer,
  });

  ExercicioModelo.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["nome"],
        treino = map["treino"],
        comoFazer = map["comoFazer"],
        urlImagem = map["urlImagem"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "treino": treino,
      "comoFazer": comoFazer,
      "urlImagem": urlImagem,
    };
  }
}
