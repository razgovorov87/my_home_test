import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_credential_dto.freezed.dart';
part 'auth_credential_dto.g.dart';

@freezed
class AuthCredentialDto with _$AuthCredentialDto {
  const factory AuthCredentialDto({
    required String login,
    required String password,
  }) = _AuthCredentialDto;

  const AuthCredentialDto._();

  factory AuthCredentialDto.fromJson(Map<String, Object?> json) => _$AuthCredentialDtoFromJson(json);

  
}
