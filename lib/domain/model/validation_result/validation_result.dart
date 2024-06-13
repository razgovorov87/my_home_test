import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_result.freezed.dart';

@freezed
class ValidationResult<Error, Result> with _$ValidationResult<Error, Result> {
  factory ValidationResult.valid({
    required Result data,
  }) = Valid<Error, Result>;

  factory ValidationResult.invalid(List<Error> errors) = Invalid<Error, Result>;
}

extension ValidationResultExtension<Error, Result> on ValidationResult<Error, Result> {
  List<Error> get errors => when(
        valid: (_) => <Error>[],
        invalid: (List<Error> errors) => errors,
      );
}
