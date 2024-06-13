import 'package:dartz/dartz.dart';

import '../enum/domain_error.dart';
import '../model/user/user.dart';

abstract class AuthRepository {
  User? get currentUser;

  Stream<User?> get currentUserStream;

  Future<Either<DomainError, bool>> register({
    required String login,
    required String password,
  });

  Future<Either<DomainError, bool>> login({
    required String login,
    required String password,
  });

  Future<void> logout();
}
