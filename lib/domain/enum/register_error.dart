enum RegisterError {
  loginEmpty,
  passwordEmpty,
  repeatPasswordEmpty,
  passwordMismatch;

  static List<RegisterError> get loginErrors => <RegisterError>[RegisterError.loginEmpty];

  static List<RegisterError> get passwordErrors => <RegisterError>[RegisterError.passwordEmpty];

  static List<RegisterError> get repeatPasswordErrors => <RegisterError>[
        RegisterError.repeatPasswordEmpty,
        RegisterError.passwordMismatch,
      ];

  String getDescription() {
    return switch (this) {
      loginEmpty => 'Обязательное поле',
      passwordEmpty => 'Обязательное поле',
      repeatPasswordEmpty => 'Обязательное поле',
      passwordMismatch => 'Пароли должны совпадать',
    };
  }
}

extension RegisterErrorListExtension on List<RegisterError> {
  List<RegisterError> get loginErrors => toSet().intersection(RegisterError.loginErrors.toSet()).toList();

  List<RegisterError> get passwordErrors => toSet().intersection(RegisterError.passwordErrors.toSet()).toList();

  List<RegisterError> get repeatPasswordErrors =>
      toSet().intersection(RegisterError.repeatPasswordErrors.toSet()).toList();

  bool get containsLoginErrors => loginErrors.isNotEmpty;
  bool get containsPasswordErrors => passwordErrors.isNotEmpty;
  bool get containsRepeatPasswordErrors => repeatPasswordErrors.isNotEmpty;

  RegisterError? get loginError => loginErrors.firstOrNull;
  RegisterError? get passwordError => passwordErrors.firstOrNull;
  RegisterError? get repeatPasswordError => repeatPasswordErrors.firstOrNull;
}
