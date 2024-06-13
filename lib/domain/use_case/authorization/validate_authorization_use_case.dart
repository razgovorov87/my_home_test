import 'package:injectable/injectable.dart';

import '../../../presentation/flow/auth_flow/screens/authorization_screen/cubit/authorization_cubit/authorization_cubit.dart';
import '../../enum/authorization_error.dart';
import '../../model/validation_result/validation_result.dart';

@injectable
class ValidateAuthorizationUseCase {
  ValidationResult<AuthorizationError, void> execute(
    AuthorizationValidateRequest request,
  ) {
    final List<AuthorizationError> errors = <AuthorizationError>[
      if (request.login == null) AuthorizationError.loginEmpty,
      if (request.password == null) AuthorizationError.passwordEmpty,
    ];

    if (errors.isEmpty) {
      return ValidationResult<AuthorizationError, void>.valid(data: null);
    }

    return ValidationResult<AuthorizationError, void>.invalid(errors);
  }
}
