import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/user/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String login,
  }) = _UserDto;

  const UserDto._();

  factory UserDto.fromJson(Map<String, Object?> json) => _$UserDtoFromJson(json);

  User toDomain() => User(login: login);
}
