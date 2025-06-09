class Constants {

  static const String baseUurl = "http://10.0.2.2:8755";

  static const String userAPI = '$baseUurl/user/api';
  static const String userCreatePin = '$baseUurl/user/api/pincreate';
  static const String login = '$baseUurl/user/login';
  static const String userByUsername = '$baseUurl/user/api/username';
  static const String userByUtente = '$baseUurl/user/api/utente';
  static const String userNovo = '$baseUurl/user/api/novo';

  static const String agendaAPI = '$baseUurl/agenda/api';
  static const String agendaMes = '$baseUurl/agenda/api/month/';
  static const String agendaDia = '$baseUurl/agenda/api/day/';

  static const String medicamentoAPI = '$baseUurl/medicamento/api';
  static const String medicamentoByUserId = '$baseUurl/medicamento/api/user';

}