import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:houlalaadministrator/model/order_model.dart';
import 'package:http/http.dart';

class OrderService extends ChangeNotifier{
  Future<List<Order>> _fetchCartItems(String uri) async {
    var url = Uri.parse(uri);
    Response response = await get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Order> orders =
      body.map((dynamic order) => Order.fromJson(order)).toList();
      return orders;
    } else {
      throw "Aucunes commandes";
    }
  }

  Stream<List<Order>> fetchOrders(String uri) async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      List<Order> orders = await _fetchCartItems(uri);
      yield orders;
    }
  }

  Future<List<Order>> getOrders(String uri) async {
    return  await _fetchCartItems(uri);
  }

}