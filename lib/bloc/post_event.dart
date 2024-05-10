part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class FetchPostData extends PostEvent {}

class AddPost extends PostEvent {
  final Post post;

  AddPost({required this.post});
}
