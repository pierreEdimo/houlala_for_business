import 'package:equatable/equatable.dart';

class ProductType extends Equatable {
  final String? id;
  final String? label;

  ProductType({
    this.id,
    this.label,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) => ProductType(
        id: json['_id'] as String,
        label: json['label'] as String,
      );

  @override
  List<Object?> get props => [id];
}
