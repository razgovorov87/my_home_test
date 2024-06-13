import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../domain/enum/register_error.dart';
import '../../../../../../design/widgets/custom_text_field.dart';
import '../register_cubit/register_cubit.dart';

class RegisterRepeatPasswordField extends StatelessWidget {
  const RegisterRepeatPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (RegisterState previous, RegisterState current) =>
          previous.validationErrors.containsRepeatPasswordErrors !=
          current.validationErrors.containsRepeatPasswordErrors,
      builder: (BuildContext context, RegisterState state) {
        final RegisterError? error = state.validationErrors.repeatPasswordError;

        return CustomTextField(
          label: 'Repeat Password',
          obscureText: true,
          onChanged: context.read<RegisterCubit>().setRepeatPassword,
          error: error?.getDescription(),
        );
      },
    );
  }
}
