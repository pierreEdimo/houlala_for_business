import 'package:houlalaadministrator/model/product_model.dart';

class CartItem{
  final String? id;
  final int? quantity;
  int? totalPrice;
  final ProductModel? product;

  CartItem({
    this.id,
    this.quantity,
    this.totalPrice,
    this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json['_id'] as String,
    quantity: json['quantity'] as int,
    totalPrice: json['totalPrice'] as int,
    product: ProductModel.fromJson(json['product']),
  );
}