import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/api_failure/api_failure.dart';
import '../../domain/model/post/post.dart';
import '../../domain/repository/posts_repository.dart';
import '../dto/post_dto/post_dto.dart';
import '../source/remote/posts_source.dart';

@LazySingleton(as: PostsRepository)
class PostsRepositoryImpl implements PostsRepository {
  PostsRepositoryImpl(
    this._source,
  );

  final PostsSource _source;

  @override
  Future<Either<APIFailure, List<Post>>> getAllPosts() async {
    final Either<APIFailure, Response<dynamic>> response = await _source.getAllPosts();

    return response.fold(
      (APIFailure failure) => left(failure),
      (Response<dynamic> result) => right(
        (result.data as List<dynamic>)
            .map(
              (dynamic e) => PostDto.fromJson(e as Map<String, dynamic>).toDomain(),
            )
            .toList(),
      ),
    );
  }
}
