import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/user/user.dart';
import '../../injectable.dart';
import '../cubit/current_user_cubit/current_user_cubit.dart';
import '../router/auto_router.dart';
import '../router/auto_router.gr.dart';

class AuthListener extends StatelessWidget {
  const AuthListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentUserCubit, User?>(
      listenWhen: (User? previous, User? current) => (previous ?? false) != current,
      listener: (BuildContext context, User? state) {
        if (state != null) {
          getIt.get<AppRouter>().replace(const MainFlow());
        } else {
          getIt.get<AppRouter>().replace(const AuthFlow());
        }
      },
      child: child,
    );
  }
}
