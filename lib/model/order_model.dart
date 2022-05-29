import 'package:houlalaadministrator/model/cart_item.dart';
import 'package:houlalaadministrator/model/user_information.dart';

import 'address.dart';

class Order {
  Order({
    this.userInformation,
    this.address,
    this.id,
    this.pageId,
    this.cartItems,
    this.status,
    this.paymentMode,
    this.totalQuantity,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
  });

  final UserInformation? userInformation;
  final Address? address;
  final String? id;
  final String? pageId;
  final List<CartItem>? cartItems;
  final String? status;
  final String? paymentMode;
  final int? totalQuantity;
  final int? totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        userInformation: UserInformation.fromJson(json["userInformation"]),
        address: Address.fromJson(json["address"]),
        id: json["_id"],
        pageId: json["pageId"],
        cartItems: List<CartItem>.from(
          json["cartItems"].map(
            (x) => CartItem.fromJson(x),
          ),
        ),
        status: json["status"],
        paymentMode: json["paymentMode"],
        totalQuantity: json["totalQuantity"],
        totalPrice: json["totalPrice"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userInformation": userInformation!.toJson(),
        "address": address!.toJson(),
        "_id": id,
        "pageId": pageId,
        "cartItems": List<CartItem>.from(cartItems!.map((x) => x)),
        "status": status,
        "paymentMode": paymentMode,
        "totalQuantity": totalQuantity,
        "totalPrice": totalPrice,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}


