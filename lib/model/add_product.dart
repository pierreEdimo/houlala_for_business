class AddProduct {
  final String? name;
  final String? description;
  final int? weight;
  final int? sellingPrice;
  final String? categoryId;
  final String? pageId;
  final String? productType;
  final int? buyingPrice;
  final int? quantity;

  AddProduct({
    this.name,
    this.description,
    this.weight,
    this.sellingPrice,
    this.categoryId,
    this.pageId,
    this.productType,
    this.buyingPrice,
    this.quantity,
  });

  factory AddProduct.fromJson(Map<String, dynamic> json) => AddProduct(
    name: json['name'] as String,
    description: json['description'] as String,
    weight: json['weight'] as int,
    sellingPrice: json['initialPrice'] as int,
    categoryId: json['categoryId'] as String,
    pageId: json['page'] as String,
    productType: json['productType'] as String,
    buyingPrice: json['buyingPrice'] as int,
    quantity: json['quantity'] as int,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "weight": weight,
    "initialPrice": sellingPrice,
    "categoryId":categoryId,
    "page":pageId,
    "productType":productType,
    "buyingPrice":buyingPrice,
    "quantity": quantity
  };
}


