import 'package:fetch_post/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (context) => PostBloc()..add(FetchPostData()),
      child: MaterialApp(
        title: 'Post Fetch API',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PostPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
