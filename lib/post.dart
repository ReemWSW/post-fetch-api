import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fetch_post/bloc/post_bloc.dart';

import 'widget.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoadingEvent) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostSuccessEvent) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return PostContainer(
                  data: post,
                );
              },
            );
          } else if (state is PostFailureEvent) {
            return Center(child: Text(state.error));
          } else {
            return Center(child: Text('Unknown state: $state'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<PostBloc>(context).add(FetchPostData());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
