import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable{
  final String? id;
  final String? name;

  CategoryModel({
    this.id,
    this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['_id'] as String,
    name: json['name'] as String,
  );

  @override
  List<Object?> get props => [id];
}
