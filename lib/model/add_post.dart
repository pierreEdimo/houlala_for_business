class AddPost {
  final String? content;
  final String? pageId;

  AddPost({
    this.content,
    this.pageId,
  });

  factory AddPost.fromJson(Map<String, dynamic> json) => AddPost(
        content: json['content'] as String,
        pageId: json['page'] as String,
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "page": pageId,
      };
}
