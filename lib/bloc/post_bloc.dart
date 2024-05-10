import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:fetch_post/model/post_model.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<FetchPostData>(_onStart);
    on<AddPost>(_onAddPost);
  }

  void _onStart(FetchPostData event, Emitter<PostState> emit) async {
    emit(PostLoadingEvent());
    try {
      var url = Uri.https('jsonplaceholder.typicode.com', '/posts');

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<Post> posts = (json.decode(response.body) as List)
            .map((data) => Post.fromJson(data))
            .toList();

        emit(PostSuccessEvent(posts: posts));
      } else {
        emit(PostFailureEvent(error: 'Failed to load posts'));
      }
    } catch (e) {
      emit(PostFailureEvent(error: 'Error: $e'));
    }
  }

  void _onAddPost(AddPost event, Emitter<PostState> emit) {
    if (state is PostSuccessEvent) {
      final List<Post> updatedPosts =
          List.from((state as PostSuccessEvent).posts);
      updatedPosts.add(event.post);
      emit(PostSuccessEvent(posts: updatedPosts));
    }
  }
}
