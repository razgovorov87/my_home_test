import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/api_failure/api_failure.dart';
import '../../../domain/model/post/post.dart';
import '../../../domain/use_case/posts/get_all_posts_use_case.dart';

part 'posts_cubit.freezed.dart';
part 'posts_state.dart';

@lazySingleton
class PostsCubit extends Cubit<PostsState> {
  PostsCubit(
    this._getAllPostsUseCase,
  ) : super(const PostsState()) {
    getPosts();
  }

  final GetAllPostsUseCase _getAllPostsUseCase;

  Future<void> getPosts() async {
    final Either<APIFailure, List<Post>> result = await _getAllPostsUseCase.execute();

    result.fold(
      (APIFailure l) {
        emit(state.copyWith(isLoading: false));
      },
      (List<Post> posts) {
        emit(state.copyWith(isLoading: false, posts: posts));
      },
    );
  }
}
