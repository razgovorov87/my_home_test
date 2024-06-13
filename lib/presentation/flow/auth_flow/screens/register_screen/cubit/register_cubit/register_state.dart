part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    String? login,
    String? password,
    String? repeatPassword,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(<RegisterError>[]) List<RegisterError> validationErrors,
    String? domainError,
  }) = _RegisterState;
}

@freezed
class RegisterValidationRequest with _$RegisterValidationRequest {
  const factory RegisterValidationRequest({
    required String? login,
    required String? password,
    required String? repeatPassword,
  }) = _RegisterValidationRequest;
}
