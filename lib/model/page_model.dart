import 'package:houlalaadministrator/model/page_specialisation.dart';
import 'package:houlalaadministrator/model/post_model.dart';
import 'package:houlalaadministrator/model/product_model.dart';

class PageModel {
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? email;
  final String? telephoneNumber;
  final bool? isVerified;
  final int? companySize;
  final String? headQuartersCountry;
  final String? headQuartersCity;
  final Specialisation? pageSpecialisation;
  final String? description;
  final int? productCount;
  final int? successSold;
  final int? canceled;
  final int? totalOrders;
  final List<ProductModel> productLists;
  final List<PostModel> posts;
  final DateTime? createdAt;
  final int? pendingOrderCount;
  final int? approxRevenue;
  final int? totalRevenueFromSell;
  final int? orderUnderWay;

  PageModel(
      {this.name,
      this.imageUrl,
      this.id,
      this.email,
      this.telephoneNumber,
      this.isVerified,
      this.headQuartersCountry,
      this.headQuartersCity,
      this.pageSpecialisation,
      this.canceled,
      this.totalOrders,
      this.successSold,
      this.productCount,
      this.description,
      this.createdAt,
      required this.productLists,
      this.pendingOrderCount,
      this.approxRevenue,
      this.totalRevenueFromSell,
      this.orderUnderWay,
      required this.posts,
      this.companySize});

  factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
        productCount: json['product_count'] as int,
        successSold: json['successfull_sold'] as int,
        canceled: json['canceled_order_count'] as int,
        totalOrders: json['total_orders'] as int,
        id: json['_id'] as String,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String,
        email: json['email'] as String,
        headQuartersCountry: json['headQuarters_country'] as String,
        headQuartersCity: json['headQuarters_city'] as String,
        pageSpecialisation:
            Specialisation.fromJson(json['page_specialisation']),
        isVerified: json['isVerifed'] as bool,
        companySize: json['companySize'] as int,
        description: json['description'] as String,
        telephoneNumber: json['telephoneNumber'] as String,
        approxRevenue: json['approx_revenue'] as int,
        pendingOrderCount: json['pending_order_count'] as int,
        orderUnderWay: json['order_under_way'] as int,
        totalRevenueFromSell: json['total_revenue_from_sells'] as int,
        createdAt: DateTime.parse(json["createdAt"]),
        posts: List<PostModel>.from(
          json['posts'].map(
            (x) => PostModel.fromJson(x),
          ),
        ),
        productLists: List<ProductModel>.from(
          json["productLists"].map(
            (x) => ProductModel.fromJson(x),
          ),
        ),
      );
}
