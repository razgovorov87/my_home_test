part of 'posts_cubit.dart';

@freezed
class PostsState with _$PostsState {
  const factory PostsState({
    @Default(true) bool isLoading,
    @Default(<Post>[]) List<Post> posts,
  }) = _PostsState;
}
