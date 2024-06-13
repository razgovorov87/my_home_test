import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../enum/domain_error.dart';
import '../../repository/auth_repository.dart';

@injectable
class AuthorizationUseCase {
  AuthorizationUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<Either<DomainError, bool>> execute({
    required String login,
    required String password,
  }) =>
      _authRepository.login(login: login, password: password);
}
