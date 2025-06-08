class TokenInvalidoException implements Exception {
  final String message;
  TokenInvalidoException([this.message = 'Token inválido ou expirado']);
  @override
  String toString() => message;
}
