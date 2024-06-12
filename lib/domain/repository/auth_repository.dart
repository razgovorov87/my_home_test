import '../model/user/user.dart';

abstract class AuthRepository {
  User? get currentUser;

  Stream<User?> get currentUserStream;

  Future<void> register({
    required String login,
    required String password,
  });

  Future<void> login({
    required String login,
    required String password,
  });

  Future<void> logout();
}
