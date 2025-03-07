class Module {
  final int id;
  final String nome;
  final String descricao;
  final String rota;
  final String icone;
  final int ordem;
  final bool ativo;

  Module({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.rota,
    required this.icone,
    required this.ordem,
    required this.ativo,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      rota: json['rota'],
      icone: json['icone'],
      ordem: json['ordem'],
      ativo: json['ativo'],
    );
  }
}
