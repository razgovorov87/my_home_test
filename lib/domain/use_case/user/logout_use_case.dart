import 'package:injectable/injectable.dart';

import '../../repository/auth_repository.dart';

@injectable
class LogoutUseCase {
  LogoutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<void> execute() => _authRepository.logout();
}
