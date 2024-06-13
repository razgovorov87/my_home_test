import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../domain/enum/authorization_error.dart';
import '../../../../../design/widgets/custom_text_field.dart';
import '../cubit/authorization_cubit/authorization_cubit.dart';

class AuthorizationLoginField extends StatelessWidget {
  const AuthorizationLoginField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationCubit, AuthorizationState>(
      buildWhen: (AuthorizationState previous, AuthorizationState current) =>
          previous.validationErrors.containsLoginErrors != current.validationErrors.containsLoginErrors,
      builder: (BuildContext context, AuthorizationState state) {
        final AuthorizationError? error = state.validationErrors.loginError;

        return CustomTextField(
          label: 'Login',
          onChanged: context.read<AuthorizationCubit>().setLogin,
          error: error?.getDescription(),
        );
      },
    );
  }
}
