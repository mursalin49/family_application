import 'dart:async';

class AuthService {
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return email == "" && password == "";
  }

  Future<bool> createAccount(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
