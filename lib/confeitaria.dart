class Confeitaria {
  final int? id;
  final String nome;
  final double latitude;
  final double longitude;
  final String cep;
  final String rua;
  final String numero;
  final String bairro;
  final String cidade;
  final String estado;
  final String telefone;

  Confeitaria({
    this.id,
    required this.nome,
    required this.latitude,
    required this.longitude,
    required this.cep,
    required this.rua,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.telefone,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'nome': nome,
      'latitude': latitude,
      'longitude': longitude,
      'cep': cep,
      'rua': rua,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'telefone': telefone,
    };
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }

  factory Confeitaria.fromMap(Map<String, dynamic> map) {
    return Confeitaria(
      id: map['id'],
      nome: map['nome'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      cep: map['cep'],
      rua: map['rua'],
      numero: map['numero'],
      bairro: map['bairro'],
      cidade: map['cidade'],
      estado: map['estado'],
      telefone: map['telefone'],
    );
  }
}
