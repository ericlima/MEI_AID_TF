import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meditrack/model/agenda_dto.dart';
import 'package:meditrack/model/agenda_mapper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import '../model/constants.dart';

import 'package:meditrack/exception/token_invalido_exception.dart';

final FlutterSecureStorage _storage = FlutterSecureStorage();

class InserirAgendaException implements Exception {
  final String message;
  InserirAgendaException(this.message);

  @override
  String toString() => 'InserirAgendaException: $message';
}

class AtualizarAgendaException implements Exception {
  final String message;
  AtualizarAgendaException(this.message);
  @override
  String toString() => 'AtualizarAgendaException: $message';
}

Future<String> login(String username, String password) async {
  final url = Uri.parse(Constants.login);

  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'username': username,
    'password': password,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['token'] ?? "";
    } else {
      print('Login inválido: ${response.statusCode}');
      return "";
    }
  } catch (e) {
    print('Erro de rede: $e');
    return "";
  }
}

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw TokenInvalidoException('Formato inválido de token JWT');
  }

  final payload = parts[1];
  String normalized = base64Url.normalize(payload);

  try {
    final decoded = utf8.decode(base64Url.decode(normalized));
    final payloadMap = jsonDecode(decoded);

    if (payloadMap is! Map<String, dynamic>) {
      throw TokenInvalidoException('Payload inválido no JWT');
    }

    return payloadMap;
  } catch (e) {
    throw TokenInvalidoException('Falha ao decodificar JWT: $e');
  }
}

Future<List<Appointment>> getAppointmentsFromApi(String url) async {
  final _storage = FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  if (token == null || token.isEmpty) throw TokenInvalidoException();

  final payload = parseJwt(token);
  if (payload.isEmpty) throw TokenInvalidoException();

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    final List<AgendaDTO> listaDTO = data
        .map((item) => AgendaDTO.fromJson(item as Map<String, dynamic>))
        .toList();
    return AgendaMapper.fromDTOList(listaDTO);
  } else {
    throw Exception('Erro ao obter agenda: ${response.statusCode}');
  }
}

Future<List<Appointment>> obtemAgendaMes(int mes) async {
  final _storage = FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  if (token == null || token.isEmpty) throw TokenInvalidoException();

  final payload = parseJwt(token);
  if (payload.isEmpty) throw TokenInvalidoException();

  final usercode = payload['usr'];
  final now = DateTime.now();
  final anoMes = '${now.year}${mes.toString().padLeft(2, '0')}';
  final url = '${Constants.agendaMes}/$usercode/$anoMes';

  return getAppointmentsFromApi(url);
}

Future<List<Appointment>> obtemAgendaDia(DateTime dia) async {
  final _storage = FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  if (token == null || token.isEmpty) throw TokenInvalidoException();

  final payload = parseJwt(token);
  if (payload.isEmpty) throw TokenInvalidoException();

  final usercode = payload['usr'];
  final dataFormatada = DateFormat('yyyy-MM-dd').format(dia);
  final url = '${Constants.agendaDia}/$usercode/$dataFormatada';

  return getAppointmentsFromApi(url);
}

Future<void> inserirAgenda(AgendaDTO agenda) async {
  final token = await _storage.read(key: 'token');
  if (token == null || token.isEmpty) {
    throw TokenInvalidoException();
  }

  final payload = parseJwt(token);
  if (payload.isEmpty || !payload.containsKey('usr')) {
    throw TokenInvalidoException();
  }

  // Atribui o ID do utilizador ao DTO a partir do token
  agenda.id = null;
  agenda.userId = int.parse(payload['usr']);

  final url = Uri.parse(Constants.agendaAPI);

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(agenda.toJson()),
    );

    //print(token);
    //print(jsonEncode(agenda.toJson()));

    if (response.statusCode != 201) {
      //print(response.statusCode);
      throw InserirAgendaException(
        'Erro ao inserir agenda: ${response.statusCode}\n${response.body}',
      );      
    }
  } catch (e) {
    //print(e);
    throw InserirAgendaException('Erro ao comunicar com o servidor: $e');
  }
}

Future<void> atualizarAgenda(AgendaDTO agenda) async {
  final _storage = FlutterSecureStorage();
  final token = await _storage.read(key: 'token');

  if (token == null || token.isEmpty) throw TokenInvalidoException();
  if (agenda.id == null || agenda.id == 0) {
    throw AtualizarAgendaException('ID da agenda ausente ou inválido para atualização.');
  }

  final payload = parseJwt(token);
  if (payload.isEmpty || !payload.containsKey('usr')) {
    throw TokenInvalidoException();
  }

  //print(agenda.id);

  final url = Uri.parse('${Constants.agendaAPI}');
  
  agenda.userId = int.parse(payload['usr']);

  print(url);

  try {
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(agenda.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      print(response.statusCode);
      throw AtualizarAgendaException(
        'Erro ao atualizar agenda: ${response.statusCode}\n${response.body}',
      );
    }
  } catch (e) {
    print(e.toString());
    throw AtualizarAgendaException('Erro ao comunicar com o servidor: $e');
  }
}

Future<void> excluirAgenda(int agendaId) async {
  final _storage = FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  if (token == null || token.isEmpty) throw TokenInvalidoException();

  final url = Uri.parse('${Constants.agendaAPI}/$agendaId');

  final response = await http.delete(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode != 200 && response.statusCode != 204) {
    throw Exception(
      'Erro ao excluir agenda: ${response.statusCode}\n${response.body}',
    );
  }
}
