class UtilizadorDTO {
  final int id;
  final String userName;
  final String nome;
  final String email;
  final String telefone;
  final String numUtente;
  final DateTime? dataNascto;
  final String? codigoPostal;
  final String? morada;
  final String? cidade;
  final String? pais;
  final DateTime? terms;
  final String? genero;

  UtilizadorDTO({
    required this.id,
    required this.userName,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.numUtente,
    this.dataNascto,
    this.codigoPostal,
    this.morada,
    this.cidade,
    this.pais,
    this.terms,
    this.genero,
  });

  factory UtilizadorDTO.fromJson(Map<String, dynamic> json) {
    return UtilizadorDTO(
      id: json['id'],
      userName: json['userName'],
      nome: json['nome'],
      email: json['email'],
      telefone: json['telefone'],
      numUtente: json['numUtente'],
      dataNascto: json['dataNascto'] != null
          ? DateTime.tryParse(json['dataNascto'])
          : null,
      codigoPostal: json['codigoPostal'],
      morada: json['morada'],
      cidade: json['cidade'],
      pais: json['pais'],
      terms: json['terms'] != null
          ? DateTime.tryParse(json['terms'])
          : null,
      genero: json['genero'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'numUtente': numUtente,
      'dataNascto': dataNascto?.toIso8601String(),
      'codigoPostal': codigoPostal,
      'morada': morada,
      'cidade': cidade,
      'pais': pais,
      'terms': terms?.toIso8601String(),
      'genero': genero,
    };
  }
}
