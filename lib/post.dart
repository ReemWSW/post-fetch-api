import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fetch_post/bloc/post_bloc.dart';

import 'new_post.dart';
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
            return RefreshIndicator(onRefresh: () async {
              BlocProvider.of<PostBloc>(context).add(FetchPostData());
            }, child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              double screenWidth = constraints.maxWidth;
              double screenHeight = constraints.maxHeight;

              double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

              String deviceType;
              if (screenWidth >= 2556) {
                deviceType = 'IPHONE14';
              } else if (screenWidth >= 1536) {
                deviceType = 'IPADAIR';
              } else {
                deviceType = 'IPHONE8';
              }

              return Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: deviceType == "IPADAIR"
                      ? MediaQuery.of(context).size.width *
                          0.6 // Adjust the width for iPad
                      : MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      final post = state.posts[index];
                      return PostContainer(
                        data: post,
                      );
                    },
                  ),
                ),
              );
            }));
          } else if (state is PostFailureEvent) {
            return Center(child: Text(state.error));
          } else {
            return Center(child: Text('Unknown state: $state'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  NewPostPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin =
                    Offset(0.0, 1.0); // Start the animation from bottom
                const end = Offset.zero; // End the animation at the top
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
