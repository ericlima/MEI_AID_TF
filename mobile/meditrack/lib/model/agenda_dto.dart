class AgendaDTO {
  int? id;
  int userId;
  final DateTime inicio;
  final DateTime? fim;
  final String titulo;
  final String local;
  final bool diaInteiro;
  final String? recorrenciaRrle;
  final String? notas;

  AgendaDTO({
    this.id,
    required this.userId,
    required this.inicio,
    this.fim,
    required this.titulo,
    required this.local,
    required this.diaInteiro,
    this.recorrenciaRrle,
    this.notas,
  });

  factory AgendaDTO.fromJson(Map<String, dynamic> json) {
    return AgendaDTO(
      id: json['id'],
      userId: json['userId'],
      inicio: DateTime.parse(json['inicio']),
      fim: json['fim'] != null ? DateTime.tryParse(json['fim']) : null,
      titulo: json['titulo'] ?? '',
      local: json['local'] ?? '',
      diaInteiro: json['diaInteiro'] ?? false,
      recorrenciaRrle: json['recorrencia_rrle'],
      notas: json['notas'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'userId': userId,
      'inicio': inicio.toIso8601String(),
      'fim': fim?.toIso8601String(),
      'titulo': titulo,
      'local': local,
      'diaInteiro': diaInteiro,
      'recorrencia_rrle': recorrenciaRrle,
      'notas': notas,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
