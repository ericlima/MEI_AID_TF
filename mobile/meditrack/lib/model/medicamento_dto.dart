class MedicamentoDTO {
  final int id;
  final int userId;
  final String descricao;
  final String posologia;
  final String preditor;
  final String local;
  final DateTime inicio;
  final DateTime? fim;
  final String pinacesso;
  final String pinopcao;
  final DateTime? datahoraCriacao;
  final DateTime? datahoraAlteracao;

  MedicamentoDTO({
    required this.id,
    required this.userId,
    required this.descricao,
    required this.posologia,
    required this.preditor,
    required this.local,
    required this.inicio,
    this.fim,
    required this.pinacesso,
    required this.pinopcao,
    this.datahoraCriacao,
    this.datahoraAlteracao,
  });

  factory MedicamentoDTO.fromJson(Map<String, dynamic> json) {
    return MedicamentoDTO(
      id: json['id'],
      userId: json['userId'],
      descricao: json['descricao'],
      posologia: json['posologia'],
      preditor: json['preditor'],
      local: json['local'],
      inicio: DateTime.parse(json['inicio']),
      fim: json['fim'] != null ? DateTime.tryParse(json['fim']) : null,
      pinacesso: json['pinacesso'],
      pinopcao: json['pinopcao'],
      datahoraCriacao: json['datahoraCriacao'] != null
          ? DateTime.tryParse(json['datahoraCriacao'])
          : null,
      datahoraAlteracao: json['datahoraAlteracao'] != null
          ? DateTime.tryParse(json['datahoraAlteracao'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'descricao': descricao,
      'posologia': posologia,
      'preditor': preditor,
      'local': local,
      'inicio': inicio.toIso8601String().split('T').first,
      'fim': fim?.toIso8601String().split('T').first,
      'pinacesso': pinacesso,
      'pinopcao': pinopcao,
      'datahoraCriacao': datahoraCriacao?.toIso8601String(),
      'datahoraAlteracao': datahoraAlteracao?.toIso8601String(),
    };
  }
}
