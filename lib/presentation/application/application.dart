import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injectable.dart';
import '../cubit/current_user_cubit/current_user_cubit.dart';
import '../router/auto_router.dart';
import 'auth_listener.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late CurrentUserCubit _currentUserCubit;

  @override
  void initState() {
    super.initState();
    _currentUserCubit = getIt.get<CurrentUserCubit>();
  }

  @override
  void dispose() {
    _currentUserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentUserCubit>.value(
      value: _currentUserCubit,
      child: AuthListener(
        child: MaterialApp.router(
          title: 'My Home Test',
          debugShowCheckedModeBanner: false,
          routerConfig: getIt.get<AppRouter>().config(),
        ),
      ),
    );
  }
}
