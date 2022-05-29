import 'package:flutter/material.dart';
import 'package:houlalaadministrator/widget/post_container.dart';

import '../model/post_model.dart';

class PostLists extends StatelessWidget {
  final List<PostModel>? posts;
  final int? crossAxisCount;

  const PostLists({Key? key, this.posts, this.crossAxisCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount: crossAxisCount!,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: posts!
          .map(
            (PostModel postModel) => PostContainer(
              postModel: postModel,
            ),
          )
          .toList(),
    );
  }
}
