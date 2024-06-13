import 'package:injectable/injectable.dart';

import '../../model/user/user.dart';
import '../../repository/auth_repository.dart';

@injectable
class GetCurrentUserUseCase {
  GetCurrentUserUseCase(this._authRepository);

  final AuthRepository _authRepository;

  User? execute() => _authRepository.currentUser;
}
