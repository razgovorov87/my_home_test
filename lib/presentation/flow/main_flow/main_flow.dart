import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../../injectable.dart';
import '../../cubit/current_user_cubit/current_user_cubit.dart';
import '../../cubit/posts_cubit/posts_cubit.dart';
import '../../router/auto_router.gr.dart';

@RoutePage()
class MainFlow extends StatefulWidget {
  const MainFlow({super.key});

  @override
  State<MainFlow> createState() => _MainFlowState();
}

class _MainFlowState extends State<MainFlow> {
  late CurrentUserCubit _currentUserCubit;
  late PostsCubit _postsCubit;

  @override
  void initState() {
    super.initState();

    _currentUserCubit = getIt.get<CurrentUserCubit>();
    _postsCubit = getIt.get<PostsCubit>();
  }

  @override
  void dispose() {
    _currentUserCubit.close();
    _postsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<CurrentUserCubit>.value(value: _currentUserCubit),
        BlocProvider<PostsCubit>.value(value: _postsCubit),
      ],
      child: AutoTabsRouter(
        routes: const <PageRouteInfo>[
          HomeRoute(),
          ProfileRoute(),
        ],
        builder: (BuildContext context, Widget child) => Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            onTap: context.tabsRouter.setActiveIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
