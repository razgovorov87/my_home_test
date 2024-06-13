part of 'authorization_cubit.dart';

@freezed
class AuthorizationState with _$AuthorizationState {
  const factory AuthorizationState({
    String? login,
    String? password,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(<AuthorizationError>[]) List<AuthorizationError> validationErrors,
    String? domainError,
  }) = _AuthorizationState;
}

@freezed
class AuthorizationValidateRequest with _$AuthorizationValidateRequest {
  const factory AuthorizationValidateRequest({
    required String? login,
    required String? password,
  }) = _AuthorizationValidateRequest;
}
