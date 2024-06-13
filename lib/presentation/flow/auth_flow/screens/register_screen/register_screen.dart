import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injectable.dart';
import '../../../../design/app_tap_animate.dart';
import '../../../../design/app_tap_unfocus.dart';
import '../../../../design/flushbar.dart';
import '../../../../design/widgets/custom_primary_button.dart';
import '../../../../router/auto_router.gr.dart';
import 'cubit/register_cubit/register_cubit.dart';
import 'cubit/widgets/login_field.dart';
import 'cubit/widgets/password_field.dart';
import 'cubit/widgets/repeat_password_field.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterCubit _registerCubit;

  @override
  void initState() {
    super.initState();
    _registerCubit = getIt.get<RegisterCubit>();
  }

  @override
  void dispose() {
    _registerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>.value(
      value: _registerCubit,
      child: BlocListener<RegisterCubit, RegisterState>(
        bloc: _registerCubit,
        listener: (BuildContext context, RegisterState state) {
          if (state.domainError != null) {
            showErrorFlushbar(context, message: state.domainError!);
          } else if (state.isSuccess) {
            context.router.push(const AuthorizationRoute());
          }
        },
        child: AppTapUnfocus(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Register',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const RegisterLoginField(),
                  const SizedBox(height: 8),
                  const RegisterPasswordField(),
                  const SizedBox(height: 14),
                  const RegisterRepeatPasswordField(),
                  const SizedBox(height: 14),
                  BlocSelector<RegisterCubit, RegisterState, bool>(
                    selector: (RegisterState state) => state.isLoading,
                    builder: (BuildContext context, bool isLoading) => CustomPrimaryButton(
                      onTap: _registerCubit.register,
                      text: 'Register',
                      isLoading: isLoading,
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppTapAnimate(
                    pressedScale: 0.99,
                    onTap: () {
                      context.router.push(const AuthorizationRoute());
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF116EEF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
