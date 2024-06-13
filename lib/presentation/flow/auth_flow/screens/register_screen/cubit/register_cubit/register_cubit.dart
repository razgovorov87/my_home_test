import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../domain/enum/domain_error.dart';
import '../../../../../../../domain/enum/register_error.dart';
import '../../../../../../../domain/model/validation_result/validation_result.dart';
import '../../../../../../../domain/use_case/register/register_use_case.dart';
import '../../../../../../../domain/use_case/register/validate_register_use_case.dart';

part 'register_cubit.freezed.dart';
part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(
    this._validateRegisterUseCase,
    this._registerUseCase,
  ) : super(const RegisterState());

  final RegisterUseCase _registerUseCase;
  final ValidateRegisterUseCase _validateRegisterUseCase;

  void setLogin(String login) {
    emit(state.copyWith(
      login: login,
      validationErrors: _removeErrors(RegisterError.loginErrors),
      domainError: null,
    ));
  }

  void setPassword(String password) {
    emit(state.copyWith(
      password: password,
      validationErrors: _removeErrors(RegisterError.passwordErrors),
      domainError: null,
    ));
  }

  void setRepeatPassword(String repeatPassword) {
    emit(state.copyWith(
      repeatPassword: repeatPassword,
      validationErrors: _removeErrors(RegisterError.repeatPasswordErrors),
      domainError: null,
    ));
  }

  Future<void> register() async {
    emit(state.copyWith(isLoading: true));

    final RegisterValidationRequest request = RegisterValidationRequest(
      login: state.login,
      password: state.password,
      repeatPassword: state.repeatPassword,
    );

    final ValidationResult<RegisterError, void> validationResult = _validateRegisterUseCase.execute(request);

    await validationResult.when(
      valid: (_) async {
        final Either<DomainError, bool> result =
            await _registerUseCase.execute(login: state.login!, password: state.password!);
        result.fold(
          (DomainError error) {
            emit(state.copyWith(isLoading: false, domainError: error.toString()));
          },
          (bool _) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
          },
        );
      },
      invalid: (List<RegisterError> errors) {
        emit(state.copyWith(isLoading: false, validationErrors: errors));
      },
    );
  }

  List<RegisterError> _removeErrors(List<RegisterError> errors) {
    return state.validationErrors.where((RegisterError error) => !errors.contains(error)).toList();
  }
}
