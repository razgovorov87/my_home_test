import 'package:dio/dio.dart';

class DioConfigurator {
  const DioConfigurator();

  Dio get defaultDio {
    return _create(
      url: 'https://my-json-server.typicode.com/typicode/demo/',
      interceptors: <Interceptor>[],
    );
  }

  Dio _create({
    required List<Interceptor> interceptors,
    required String url,
  }) {
    const Duration timeout = Duration(seconds: 30);

    final Dio dio = Dio();

    dio.options
      ..baseUrl = url
      ..connectTimeout = timeout
      ..receiveTimeout = timeout
      ..sendTimeout = timeout;

    dio.interceptors.addAll(
      <Interceptor>[
        ...interceptors,
      ],
    );

    return dio;
  }
}
