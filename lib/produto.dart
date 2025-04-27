class Produto {
  int? id;
  String nome;
  double valor;
  String descricao;
  String? imagem; // Caminho da imagem
  int confeitariaId;

  Produto({
    this.id,
    required this.nome,
    required this.valor,
    required this.descricao,
    this.imagem,
    required this.confeitariaId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'valor': valor,
      'descricao': descricao,
      'imagem': imagem,
      'confeitariaId': confeitariaId,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      valor: map['valor'],
      descricao: map['descricao'],
      imagem: map['imagem'],
      confeitariaId: map['confeitariaId'],
    );
  }
}
