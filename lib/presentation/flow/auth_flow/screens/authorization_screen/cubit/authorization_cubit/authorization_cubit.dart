import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../domain/enum/authorization_error.dart';
import '../../../../../../../domain/enum/domain_error.dart';
import '../../../../../../../domain/model/validation_result/validation_result.dart';
import '../../../../../../../domain/use_case/authorization/authorization_use_case.dart';
import '../../../../../../../domain/use_case/authorization/validate_authorization_use_case.dart';

part 'authorization_cubit.freezed.dart';
part 'authorization_state.dart';

@injectable
class AuthorizationCubit extends Cubit<AuthorizationState> {
  AuthorizationCubit(
    this._validateAuthorizationUseCase,
    this._authorizationUseCase,
  ) : super(const AuthorizationState());

  final AuthorizationUseCase _authorizationUseCase;
  final ValidateAuthorizationUseCase _validateAuthorizationUseCase;

  void setLogin(String login) {
    emit(state.copyWith(
      login: login,
      validationErrors: _removeErrors(AuthorizationError.loginErrors),
      domainError: null,
    ));
  }

  void setPassword(String password) {
    emit(state.copyWith(
      password: password,
      validationErrors: _removeErrors(AuthorizationError.passwordErrors),
      domainError: null,
    ));
  }

  Future<void> login() async {
    emit(state.copyWith(isLoading: true));

    final AuthorizationValidateRequest request = AuthorizationValidateRequest(
      login: state.login,
      password: state.password,
    );

    final ValidationResult<AuthorizationError, void> validationResult = _validateAuthorizationUseCase.execute(request);

    await validationResult.when(
      valid: (_) async {
        final Either<DomainError, bool> result =
            await _authorizationUseCase.execute(login: state.login!, password: state.password!);

        result.fold(
          (DomainError error) {
            emit(state.copyWith(isLoading: false, domainError: error.toString()));
          },
          (bool _) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
          },
        );
      },
      invalid: (List<AuthorizationError> errors) {
        emit(state.copyWith(isLoading: false, validationErrors: errors));
      },
    );
  }

  List<AuthorizationError> _removeErrors(List<AuthorizationError> errors) {
    return state.validationErrors.where((AuthorizationError error) => !errors.contains(error)).toList();
  }
}
