enum AuthorizationError {
  loginEmpty,
  passwordEmpty;

  static List<AuthorizationError> get loginErrors => <AuthorizationError>[AuthorizationError.loginEmpty];

  static List<AuthorizationError> get passwordErrors => <AuthorizationError>[AuthorizationError.passwordEmpty];

  String getDescription() {
    return switch (this) {
      loginEmpty => 'Обязательное поле',
      passwordEmpty => 'Обязательное поле',
    };
  }
}

extension AuthorizationErrorListExtension on List<AuthorizationError> {
  List<AuthorizationError> get loginErrors => toSet().intersection(AuthorizationError.loginErrors.toSet()).toList();

  List<AuthorizationError> get passwordErrors =>
      toSet().intersection(AuthorizationError.passwordErrors.toSet()).toList();

  bool get containsLoginErrors => loginErrors.isNotEmpty;
  bool get containsPasswordErrors => passwordErrors.isNotEmpty;

  AuthorizationError? get loginError => loginErrors.firstOrNull;
  AuthorizationError? get passwordError => passwordErrors.firstOrNull;
}
