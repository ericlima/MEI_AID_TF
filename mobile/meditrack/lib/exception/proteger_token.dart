import 'package:flutter/material.dart';
import 'package:meditrack/exception/token_invalido_exception.dart';
import 'package:meditrack/utilizador/login_screen.dart';

Future<T?> protegerToken<T>(BuildContext context, Future<T> Function() action) async {
  try {
    return await action();
  } on TokenInvalidoException {
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
    return null;
  }
}
