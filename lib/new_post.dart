import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fetch_post/bloc/post_bloc.dart';
import 'package:fetch_post/model/post_model.dart';

class NewPostPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  NewPostPage({Key? key}) : super(key: key); // Fix constructor signature

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('New Post'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _bodyController,
                decoration: const InputDecoration(labelText: 'Body'),
                maxLines: null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final String title = _titleController.text.trim();
                  final String body = _bodyController.text.trim();
                  if (title.isNotEmpty && body.isNotEmpty) {
                    final Post newPost =
                        Post(userId: 1, id: 0, title: title, body: body);

                    BlocProvider.of<PostBloc>(context)
                        .add(AddPost(post: newPost));

                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Title and body cannot be empty.'),
                      ),
                    );
                  }
                },
                child: const Text('Add Post'),
              ),
            ],
          ),
        ));
  }
}
