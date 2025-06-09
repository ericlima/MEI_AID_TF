class MedicamentoDTO {
  int? id;
  int? userId;
  String? descricao;
  String? posologia;
  String? preditor;
  String? local;
  DateTime? inicio;
  DateTime? fim;
  String? pinacesso;
  String? pinopcao;
  int? quantEmb;
  int? quantDia;
  int? quantPrescrita;
  int? quantDispensada;

  MedicamentoDTO({
    this.id,
    this.userId,
    this.descricao,
    this.posologia,
    this.preditor,
    this.local,
    this.inicio,
    this.fim,
    this.pinacesso,
    this.pinopcao,
    this.quantEmb,
    this.quantDia,
    this.quantPrescrita,
    this.quantDispensada,
  });

  factory MedicamentoDTO.fromJson(Map<String, dynamic> json) {
    return MedicamentoDTO(
      id: json['id'],
      userId: json['userId'],
      descricao: json['descricao'],
      posologia: json['posologia'],
      preditor: json['preditor'],
      local: json['local'],
      inicio: json['inicio'] != null ? DateTime.tryParse(json['inicio']) : null,
      fim: json['fim'] != null ? DateTime.tryParse(json['fim']) : null,
      pinacesso: json['pinacesso'],
      pinopcao: json['pinopcao'],
      quantEmb: json['quantEmb'],
      quantDia: json['quantDia'],
      quantPrescrita: json['quantPrescrita'],
      quantDispensada: json['quantDispensada'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'userId': userId,
      'descricao': descricao,
      'posologia': posologia,
      'preditor': preditor,
      'local': local,
      'inicio': inicio?.toIso8601String().split('T').first,
      'fim': fim?.toIso8601String().split('T').first,
      'pinacesso': pinacesso,
      'pinopcao': pinopcao,
      'quantEmb': quantEmb,
      'quantDia': quantDia,
      'quantPrescrita': quantPrescrita,
      'quantDispensada': quantDispensada,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
