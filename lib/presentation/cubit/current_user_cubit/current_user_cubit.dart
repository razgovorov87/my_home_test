import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/user/user.dart';
import '../../../domain/use_case/user/get_current_user_use_case.dart';
import '../../../domain/use_case/user/logout_use_case.dart';
import '../../../domain/use_case/user/watch_current_user_use_case.dart';

@lazySingleton
class CurrentUserCubit extends Cubit<User?> {
  CurrentUserCubit(
    GetCurrentUserUseCase getCurrentUserUseCase,
    WatchCurrentUserUseCase watchCurrentUserUseCase,
    this._logoutUseCase,
  ) : super(getCurrentUserUseCase.execute()) {
    _userSub = watchCurrentUserUseCase.execute().listen(emit);
  }

  late final StreamSubscription<User?> _userSub;
  final LogoutUseCase _logoutUseCase;

  bool get isAuth => state != null;

  void logout() => _logoutUseCase.execute();

  @override
  Future<void> close() {
    _userSub.cancel();
    return super.close();
  }
}
