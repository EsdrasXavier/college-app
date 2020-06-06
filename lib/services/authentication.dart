import 'dart:async';

abstract class BaseAuth {
  Future<String> signUp(String email, String password);

  Future<String> getCurrentUser();

  Future<void> signOut();
}

class Auth implements BaseAuth {
  Future<String> signUp(String email, String password) async {
    print("Logando com e-mail: " + email + " e senha: " + password);
    return "teste";
  }

  Future<String> getCurrentUser() async {
    return null;
  }

  Future<void> signOut() async {
    print("Deslogando...");
    return null;
  }
}
