import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../domain/enum/register_error.dart';
import '../../../../../../design/widgets/custom_text_field.dart';
import '../register_cubit/register_cubit.dart';

class RegisterPasswordField extends StatelessWidget {
  const RegisterPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (RegisterState previous, RegisterState current) =>
          previous.validationErrors.containsPasswordErrors != current.validationErrors.containsPasswordErrors,
      builder: (BuildContext context, RegisterState state) {
        final RegisterError? error = state.validationErrors.passwordError;

        return CustomTextField(
          label: 'Password',
          obscureText: true,
          onChanged: context.read<RegisterCubit>().setPassword,
          error: error?.getDescription(),
        );
      },
    );
  }
}
