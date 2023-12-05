// ignore_for_file: public_member_api_docs, sort_constructors_first
class Refeicao {
  final String nameRefeicao;
  final String nomeAlimento;
  final int qtdAlimento;

  Refeicao({
    required this.nameRefeicao,
    required this.nomeAlimento,
    required this.qtdAlimento,
  });

  

  @override
  String toString() => 'Refeicao(nameRefeicao: $nameRefeicao, nomeAlimento: $nomeAlimento, qtdAlimento: $qtdAlimento)';


}
