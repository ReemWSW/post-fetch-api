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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<PostBloc>(
        create: (BuildContext context) => PostBloc()..add(FetchPostData()),
        child: const PostPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
