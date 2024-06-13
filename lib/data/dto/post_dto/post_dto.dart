import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/post/post.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

@freezed
class PostDto with _$PostDto {
  const factory PostDto({
    required int id,
    required String title,
  }) = _PostDto;

  const PostDto._();

  factory PostDto.fromJson(Map<String, Object?> json) => _$PostDtoFromJson(json);

  Post toDomain() => Post(
        id: id,
        title: title,
      );
}
