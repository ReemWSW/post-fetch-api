part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoadingEvent extends PostState {}

class PostSuccessEvent extends PostState {
  final List<Post> posts;

  PostSuccessEvent({required this.posts});
}

class PostFailureEvent extends PostState {
  final String error;

  PostFailureEvent({required this.error});
}
