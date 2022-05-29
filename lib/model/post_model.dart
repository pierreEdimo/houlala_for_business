class PostModel {
  final String? imageUrl;
  final String? content;
  final String? id;
  final DateTime? createdAt;

  PostModel({
    this.imageUrl,
    this.content,
    this.id,
    this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        imageUrl: json['imageUrl'] as String,
        id: json['_id'] as String,
        content: json['content'] as String,
        createdAt: DateTime.parse(json['createdAt']),
      );
}
