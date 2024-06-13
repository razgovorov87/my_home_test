import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/model/post/post.dart';
import '../../../../cubit/posts_cubit/posts_cubit.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double paddingTop = MediaQuery.paddingOf(context).top;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: paddingTop + 24),
        child: BlocBuilder<PostsCubit, PostsState>(
          builder: (BuildContext context, PostsState state) => state.isLoading
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CupertinoActivityIndicator(),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  itemBuilder: (BuildContext context, int index) => _PostItem(
                    item: state.posts[index],
                  ),
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 12),
                  itemCount: state.posts.length,
                ),
        ),
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  const _PostItem({
    required this.item,
  });

  final Post item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 12,
            color: Colors.black12,
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 32,
            width: 32,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent,
            ),
            child: Text(
              '${item.id}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(item.title),
        ],
      ),
    );
  }
}
