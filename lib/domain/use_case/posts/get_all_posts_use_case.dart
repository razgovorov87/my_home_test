import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../model/api_failure/api_failure.dart';
import '../../model/post/post.dart';
import '../../repository/posts_repository.dart';

@injectable
class GetAllPostsUseCase {
  GetAllPostsUseCase(this._postsRepository);

  final PostsRepository _postsRepository;

  Future<Either<APIFailure, List<Post>>> execute() => _postsRepository.getAllPosts();
}
