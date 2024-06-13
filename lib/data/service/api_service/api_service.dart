import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/api_failure/api_failure.dart';
import 'api_strings.dart';
import 'dio_configurator.dart';

@Singleton()
class APIService {
  APIService() {
    _dio = const DioConfigurator().defaultDio;
  }
  late Dio _dio;

  Future<Either<APIFailure, Response<dynamic>>> getData(
    String endpoint, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Map<String, dynamic> data = const <String, dynamic>{},
    Map<String, dynamic> headers = const <String, dynamic>{},
  }) async {
    try {
      final Response<dynamic> response = await _dio.fetch<dynamic>(
        _setStreamType<dynamic>(Options(
          method: 'GET',
          headers: headers,
          extra: <String, dynamic>{},
        ).compose(
          _dio.options.copyWith(baseUrl: _dio.options.baseUrl),
          endpoint,
          queryParameters: queryParameters,
          data: data,
        )),
      );
      return right(response);
    } catch (e) {
      return left(_formatError(e));
    }
  }

  Future<Either<APIFailure, Response<dynamic>>> postData(
    String endpoint, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Map<String, dynamic> data = const <String, dynamic>{},
    Map<String, dynamic> headers = const <String, dynamic>{},
    FormData? formData,
    StreamSink<(int, int)>? onSendProgress,
  }) async {
    try {
      final Response<dynamic> response = await _dio.fetch<dynamic>(
        _setStreamType<dynamic>(Options(
          method: 'POST',
          headers: headers,
          extra: <String, dynamic>{},
        ).compose(
          _dio.options.copyWith(baseUrl: _dio.options.baseUrl),
          endpoint,
          queryParameters: queryParameters,
          data: formData ?? data,
          onSendProgress: onSendProgress != null ? (int count, int total) => onSendProgress.add((count, total)) : null,
        )),
      );
      return right(response);
    } catch (e) {
      return left(_formatError(e));
    }
  }

  Future<Either<APIFailure, Response<dynamic>>> putData(
    String endpoint, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Map<String, dynamic> data = const <String, dynamic>{},
    Map<String, dynamic> headers = const <String, dynamic>{},
  }) async {
    try {
      final Response<dynamic> response = await _dio.fetch<dynamic>(
        _setStreamType<dynamic>(Options(
          method: 'PUT',
          headers: headers,
          extra: <String, dynamic>{},
        ).compose(
          _dio.options.copyWith(baseUrl: _dio.options.baseUrl),
          endpoint,
          queryParameters: queryParameters,
          data: data,
        )),
      );
      return right(response);
    } catch (e) {
      return left(_formatError(e));
    }
  }

  Future<Either<APIFailure, Response<dynamic>>> deleteData(
    String endpoint, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Map<String, dynamic> data = const <String, dynamic>{},
    Map<String, dynamic> headers = const <String, dynamic>{},
  }) async {
    try {
      final Response<dynamic> response = await _dio.fetch<dynamic>(
        _setStreamType<dynamic>(Options(
          method: 'DELETE',
          headers: headers,
          extra: <String, dynamic>{},
        ).compose(
          _dio.options.copyWith(baseUrl: _dio.options.baseUrl),
          endpoint,
          queryParameters: queryParameters,
          data: data,
        )),
      );
      return right(response);
    } catch (e) {
      return left(_formatError(e));
    }
  }

  Future<Either<APIFailure, Response<dynamic>>> patchData(
    String endpoint, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Map<String, dynamic> data = const <String, dynamic>{},
    FormData? formData,
    Map<String, dynamic> headers = const <String, dynamic>{},
  }) async {
    try {
      final Response<dynamic> response = await _dio.fetch<dynamic>(
        _setStreamType<dynamic>(Options(
          method: 'PATCH',
          headers: headers,
          extra: <String, dynamic>{},
        ).compose(
          _dio.options.copyWith(baseUrl: _dio.options.baseUrl),
          endpoint,
          queryParameters: queryParameters,
          data: formData ?? data,
        )),
      );
      return right(response);
    } catch (e) {
      return left(_formatError(e));
    }
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  APIFailure _formatError(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.badResponse && error.response != null) {
        if (error.response!.statusCode == 404) {
          return APIFailure.unexpected(message: APIStrings.defaultError);
        } else if (error.response!.statusCode == 500 || error.response!.statusCode == 502) {
          return APIFailure.unexpected(message: APIStrings.error500);
        } else {
          return APIFailure.responseError(
            errorDetails: ((error.response!.data is Map<String, dynamic>)
                ? error.response!.data
                : json.decode(error.response!.data as String)) as Map<String, dynamic>,
            statusCode: error.response!.statusCode ?? -1,
          );
        }
      } else if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return APIFailure.serverError(message: APIStrings.serverError);
      } else if (error.type == DioExceptionType.unknown && error.error != null && error.error is SocketException) {
        return APIFailure.connectionError(message: APIStrings.connectionError);
      } else {
        return APIFailure.unexpected(message: APIStrings.defaultError);
      }
    } else {
      return APIFailure.unexpected(message: APIStrings.defaultError);
    }
  }
}
