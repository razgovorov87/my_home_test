import 'package:dartz/dartz.dart';

import '../model/api_failure/api_failure.dart';
import '../model/post/post.dart';

abstract class PostsRepository {
  Future<Either<APIFailure, List<Post>>> getAllPosts();
}
