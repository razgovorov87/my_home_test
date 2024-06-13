import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injectable.dart';
import '../../../../design/app_tap_animate.dart';
import '../../../../design/app_tap_unfocus.dart';
import '../../../../design/flushbar.dart';
import '../../../../design/widgets/custom_primary_button.dart';
import '../../../../router/auto_router.gr.dart';
import 'cubit/authorization_cubit/authorization_cubit.dart';
import 'widgets/login_field.dart';
import 'widgets/password_field.dart';

@RoutePage()
class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({super.key});

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  late AuthorizationCubit _authorizationCubit;

  @override
  void initState() {
    super.initState();
    _authorizationCubit = getIt.get<AuthorizationCubit>();
  }

  @override
  void dispose() {
    _authorizationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthorizationCubit>.value(
      value: _authorizationCubit,
      child: BlocListener<AuthorizationCubit, AuthorizationState>(
        listener: (BuildContext context, AuthorizationState state) {
          if (state.domainError != null) {
            showErrorFlushbar(context, message: state.domainError!);
          } else if (state.isSuccess) {
            context.router.push(const MainFlow());
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
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const AuthorizationLoginField(),
                  const SizedBox(height: 8),
                  const AuthorizationPasswordField(),
                  const SizedBox(height: 14),
                  BlocSelector<AuthorizationCubit, AuthorizationState, bool>(
                    selector: (AuthorizationState state) => state.isLoading,
                    builder: (BuildContext context, bool isLoading) => CustomPrimaryButton(
                      onTap: _authorizationCubit.login,
                      text: 'Login',
                      isLoading: isLoading,
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppTapAnimate(
                    pressedScale: 0.99,
                    onTap: () {
                      context.router.push(const RegisterRoute());
                    },
                    child: const Text(
                      'Create account',
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
