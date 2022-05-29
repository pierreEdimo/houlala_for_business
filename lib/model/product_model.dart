class ProductModel {
  final String? id;
  final String? name;
  final String? description;
  final int? weight;
  final int? initialPrice;
  final String? imageUrl;
  final int? quantity;
  final int? buyingPrice;

  ProductModel({
    this.name,
    this.description,
    this.weight,
    this.initialPrice,
    this.imageUrl,
    this.quantity,
    this.id,
    this.buyingPrice,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['_id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        weight: json['weight'] as int,
        initialPrice: json['initialPrice'] as int,
        imageUrl: json['imageUrl'] as String,
        quantity: json['quantity'] as int,
        buyingPrice: json['buyingPrice'] as int,
      );
}
