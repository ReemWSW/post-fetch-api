import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fetch_post/bloc/post_bloc.dart';

import 'widgets/post_container.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == 0) {
      BlocProvider.of<PostBloc>(context).add(FetchPostData());
    }
  }

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
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<PostBloc>(context).add(FetchPostData());
              },
              child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return PostContainer(
                    data: post,
                  );
                },
              ),
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
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
