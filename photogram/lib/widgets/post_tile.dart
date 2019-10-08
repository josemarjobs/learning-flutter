import 'package:flutter/material.dart';
import 'package:photogram/widgets/custom_image.dart';
import 'package:photogram/widgets/post.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile(this.post);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("full screen"),
      child: cachedNetworkImage(post.mediaUrl),
    );
  }
}
