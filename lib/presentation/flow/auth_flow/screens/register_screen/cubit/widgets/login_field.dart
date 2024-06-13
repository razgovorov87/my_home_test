import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../domain/enum/register_error.dart';
import '../../../../../../design/widgets/custom_text_field.dart';
import '../register_cubit/register_cubit.dart';

class RegisterLoginField extends StatelessWidget {
  const RegisterLoginField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (RegisterState previous, RegisterState current) =>
          previous.validationErrors.containsLoginErrors != current.validationErrors.containsLoginErrors,
      builder: (BuildContext context, RegisterState state) {
        final RegisterError? error = state.validationErrors.loginError;

        return CustomTextField(
          label: 'Login',
          onChanged: context.read<RegisterCubit>().setLogin,
          error: error?.getDescription(),
        );
      },
    );
  }
}
