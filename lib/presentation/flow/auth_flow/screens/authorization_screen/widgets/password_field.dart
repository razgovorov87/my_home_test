import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../domain/enum/authorization_error.dart';
import '../../../../../design/widgets/custom_text_field.dart';
import '../cubit/authorization_cubit/authorization_cubit.dart';

class AuthorizationPasswordField extends StatelessWidget {
  const AuthorizationPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationCubit, AuthorizationState>(
      buildWhen: (AuthorizationState previous, AuthorizationState current) =>
          previous.validationErrors.containsPasswordErrors != current.validationErrors.containsPasswordErrors,
      builder: (BuildContext context, AuthorizationState state) {
        final AuthorizationError? error = state.validationErrors.passwordError;

        return CustomTextField(
          label: 'Password',
          obscureText: true,
          onChanged: context.read<AuthorizationCubit>().setPassword,
          error: error?.getDescription(),
        );
      },
    );
  }
}
