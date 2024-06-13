import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/model/user/user.dart';
import '../../../../cubit/current_user_cubit/current_user_cubit.dart';
import '../../../../design/widgets/custom_primary_button.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? currentUser = context.watch<CurrentUserCubit>().state;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (currentUser != null) ...<Widget>[
              Text(
                currentUser.login,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              CustomPrimaryButton(
                onTap: context.read<CurrentUserCubit>().logout,
                text: 'Logout',
              ),
            ] else
              const CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
