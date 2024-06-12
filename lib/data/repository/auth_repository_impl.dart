import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../domain/enum/domain_error.dart';
import '../../domain/model/user/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../dto/auth_credential_dto/auth_credential_dto.dart';
import '../dto/user_dto/user_dto.dart';
import '../source/sp_source/sp_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._spSource,
  );

  final SPSource _spSource;

  @override
  User? get currentUser => _spSource.currentUser?.toDomain();

  @override
  Stream<User?> get currentUserStream => _spSource.currentUserStream.map(
        (UserDto? event) {
          if (event == null) {
            return null;
          } else {
            return event.toDomain();
          }
        },
      );

  @override
  Future<Either<DomainError, bool>> login({required String login, required String password}) async {
    final String hash = md5.convert(utf8.encode(password)).toString();

    final AuthCredentialDto? authCredential = await _spSource.getAuthCredentials();
    if (authCredential == null) {
      return const Left<DomainError, bool>(DomainError.invalidLoginOrPassword);
    }

    if (authCredential.login == login && authCredential.password == hash) {
      return const Right<DomainError, bool>(true);
    } else {
      return const Left<DomainError, bool>(DomainError.invalidLoginOrPassword);
    }
  }

  @override
  Future<Either<DomainError, bool>> register({required String login, required String password}) async {
    try {
      final String hash = md5.convert(utf8.encode(password)).toString();

      final AuthCredentialDto credential = AuthCredentialDto(login: login, password: hash);

      await _spSource.setAuthCredential(credential);
      return const Right<DomainError, bool>(true);
    } catch (e) {
      return const Left<DomainError, bool>(DomainError.somethingWrong);
    }
  }

  @override
  Future<void> logout() => _spSource.logout();
}
