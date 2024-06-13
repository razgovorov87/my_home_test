import 'package:injectable/injectable.dart';

import '../../../presentation/flow/auth_flow/screens/register_screen/cubit/register_cubit/register_cubit.dart';
import '../../enum/register_error.dart';
import '../../model/validation_result/validation_result.dart';

@injectable
class ValidateRegisterUseCase {
  ValidationResult<RegisterError, void> execute(
    RegisterValidationRequest request,
  ) {
    final List<RegisterError> errors = <RegisterError>[
      if (request.login == null) RegisterError.loginEmpty,
      if (request.password == null) RegisterError.passwordEmpty,
      if (request.repeatPassword == null) RegisterError.repeatPasswordEmpty,
      if (request.password != request.repeatPassword) RegisterError.passwordMismatch,
    ];

    if (errors.isEmpty) {
      return ValidationResult<RegisterError, void>.valid(data: null);
    }

    return ValidationResult<RegisterError, void>.invalid(errors);
  }
}
