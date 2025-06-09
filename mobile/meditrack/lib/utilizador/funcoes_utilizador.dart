import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:meditrack/exception/token_invalido_exception.dart';
import 'package:meditrack/model/constants.dart';
import 'package:meditrack/model/loginrequest_dto.dart';
import 'package:meditrack/model/utilizador_dto.dart';
import 'package:bcrypt/bcrypt.dart';

Future<void> inserirUtilizador(UtilizadorDTO utilizador) async {
  final _storage = FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  if (token == null || token.isEmpty) throw TokenInvalidoException();
  
  final url = Uri.parse(Constants.userNovo);

  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(utilizador.toJson()),
  );

  if (response.statusCode != 201 && response.statusCode != 200) {
    throw Exception(
      'Erro ao inserir utilizador: ${response.statusCode}\n${response.body}',
    );
  }
}

Future<void> updateUtilizador(UtilizadorDTO utilizador) async {
  final _storage = FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  if (token == null || token.isEmpty) throw TokenInvalidoException();

  if (utilizador.id == 0) {
    throw Exception('ID do utilizador ausente para atualização');
  }  

  final url = Uri.parse(Constants.userAPI);

  final response = await http.put(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(utilizador.toJson()),
  );

  if (response.statusCode != 200 && response.statusCode != 204) {
    throw Exception(
      'Erro ao inserir utilizador: ${response.statusCode}\n${response.body}',
    );
  }
}

Future<void> excluirUtilizador(int utilizadorId) async {
  final _storage = FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  if (token == null || token.isEmpty) throw TokenInvalidoException();

  if (utilizadorId == 0) {
    throw Exception('ID do utilizador ausente para exclusao');
  }

  final url = Uri.parse('${Constants.userAPI}/$utilizadorId');

  final response = await http.delete(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode != 200 && response.statusCode != 204) {
    throw Exception(
      'Erro ao excluir utilizador: ${response.statusCode}\n${response.body}',
    );
  }  
}

Future<bool> usernameDisponivel(String username) async {
  final _storage = FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  if (token == null || token.isEmpty) throw TokenInvalidoException();

  final uri = Uri.parse(Constants.userByUsername).replace(
    queryParameters: {'userName': username},
  );

  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer $token',      
    },
    
  );

  // true se não existir (404), false se já existir (200)
  return response.statusCode == 404;
}


Future<bool> numUtenteDisponivel(String numUtente) async {
  final _storage = FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  if (token == null || token.isEmpty) throw TokenInvalidoException();

  final uri = Uri.parse(Constants.userByUsername).replace(
    queryParameters: {'numUtente': numUtente},
  );

  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer $token',      
    },
    
  );

  return response.statusCode == 404;
}

Future<void> criarPin(String username, String pin) async {
  
  final url = Uri.parse(Constants.userCreatePin);

  final pinHash = BCrypt.hashpw(pin, BCrypt.gensalt());

  LoginRequestDTO lrdto = LoginRequestDTO();

  lrdto.username = username;
  lrdto.password = pinHash;

  final response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(lrdto.toJson()),
  );

  if (response.statusCode != 200 && response.statusCode != 204) {
    throw Exception(
      'Erro ao criar o pin: ${response.statusCode}\n${response.body}',
    );
  }
}