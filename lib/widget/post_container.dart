import 'package:flutter/material.dart';
import 'package:houlalaadministrator/model/post_model.dart';
import 'package:houlalaadministrator/widget/custom_card.dart';

class PostContainer extends StatelessWidget {
  final PostModel? postModel;

  const PostContainer({
    Key? key,
    this.postModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            postModel!.content!,
            maxLines: postModel!.imageUrl!.isEmpty ? 7 : 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 10.0,
          ),
          postModel!.imageUrl!.isNotEmpty
              ? Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(postModel!.imageUrl!),
                          fit: BoxFit.cover),
                    ),
                  ),
                )
              : Container(),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(
                Icons.comment_bank_outlined,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text("12")
            ],
          )
        ],
      ),
    );
  }
}
