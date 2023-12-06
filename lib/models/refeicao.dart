// ignore_for_file: public_member_api_docs, sort_constructors_first
class Refeicao {
  final int id;
  final String nomeRefeicao;
  final String nomeAlimento;
  final int qtdAlimento;

  Refeicao({
    required this.id,
    required this.nomeRefeicao,
    required this.nomeAlimento,
    required this.qtdAlimento,
  });

  

  @override
  String toString() {
    return 'Refeicao(id: $id, nomeRefeicao: $nomeRefeicao, nomeAlimento: $nomeAlimento, qtdAlimento: $qtdAlimento)';
  }
}
