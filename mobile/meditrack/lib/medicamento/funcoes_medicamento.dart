import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:meditrack/exception/token_invalido_exception.dart';
import 'package:meditrack/model/constants.dart';
import 'package:meditrack/model/medicamento_dto.dart';

Future<void> inserirMedicamento(MedicamentoDTO medicamento) async {
  final _storage = FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  if (token == null || token.isEmpty) throw TokenInvalidoException();

  final url = Uri.parse(Constants.medicamentoAPI);

  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(medicamento.toJson()),
  );

  if (response.statusCode != 201 && response.statusCode != 200) {
    throw Exception(
      'Erro ao inserir medicamento: ${response.statusCode}\n${response.body}',
    );
  }
}

Future<void> atualizarMedicamento(MedicamentoDTO medicamento) async {
  final _storage = FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  if (token == null || token.isEmpty) throw TokenInvalidoException();

  if (medicamento.id == 0) {
    throw Exception('ID do medicamento ausente para atualização');
  }

  final url = Uri.parse('${Constants.medicamentoAPI}/${medicamento.id}');

  final response = await http.put(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(medicamento.toJson()),
  );

  if (response.statusCode != 200 && response.statusCode != 204) {
    throw Exception(
      'Erro ao atualizar medicamento: ${response.statusCode}\n${response.body}',
    );
  }
}

Future<void> excluirMedicamento(int medicamentoId) async {
  final _storage = FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  if (token == null || token.isEmpty) throw TokenInvalidoException();

  if (medicamentoId == 0) {
    throw Exception('ID do medicamento ausente para exclusão');
  }

  final url = Uri.parse('${Constants.medicamentoAPI}/$medicamentoId');

  final response = await http.delete(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode != 200 && response.statusCode != 204) {
    throw Exception(
      'Erro ao excluir medicamento: ${response.statusCode}\n${response.body}',
    );
  }
}
