import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_failure.freezed.dart';

@freezed
abstract class APIFailure with _$APIFailure {
  const factory APIFailure.unexpected({
    required String message,
  }) = _Unexpected;

  const factory APIFailure.responseError({
    required Map<String, dynamic> errorDetails,
    required int statusCode,
  }) = _ResponseError;

  const factory APIFailure.serverError({
    required String message,
  }) = _ServerError;

  const factory APIFailure.connectionError({
    required String message,
  }) = _ConnectionError;
}
