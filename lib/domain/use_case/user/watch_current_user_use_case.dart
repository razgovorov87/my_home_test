import 'package:injectable/injectable.dart';

import '../../model/user/user.dart';
import '../../repository/auth_repository.dart';

@injectable
class WatchCurrentUserUseCase {
  WatchCurrentUserUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Stream<User?> execute() => _authRepository.currentUserStream;
}
