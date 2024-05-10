import 'package:fetch_post/model/post_model.dart';
import 'package:flutter/material.dart';

class PostContainer extends StatelessWidget {
  final Post data;

  const PostContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'User ID: ${data.userId}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'ID: ${data.id}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        InkWell(
                          child: const Icon(
                            Icons.more_vert,
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${data.title}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${data.body}',
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
