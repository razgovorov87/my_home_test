import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/api_failure/api_failure.dart';
import '../../service/api_service/api_service.dart';
import '../../service/api_service/api_strings.dart';

@Singleton()
class PostsSource {
  PostsSource(this._apiService);

  final APIService _apiService;

  Future<Either<APIFailure, Response<dynamic>>> getAllPosts() async {
    return _apiService.getData(APIStrings.postsEndpoint);
  }
}
