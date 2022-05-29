import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../constant/boxes.dart';
import '../model/page_model.dart';
import '../model/product_model.dart';

class PageService extends ChangeNotifier {
  final _userIdBox = HiveBoxes.getUserId();

  Future<PageModel> _fetchSinglePage() async {
    var userId = _userIdBox.get("userId");
    var url = Uri.parse(
        'https://houlala.herokuapp.com/api/pages/filterPageByUserId?userId=$userId');
    Response response = await get(url);
    if (response.statusCode == 200) {
      return PageModel.fromJson(jsonDecode(response.body));
    } else {
      throw "No Product found";
    }
  }

  Stream<PageModel> getSinglePage() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      PageModel pageModel = await _fetchSinglePage();
      yield pageModel;
    }
  }

  getAllExpensesFromProduct(ProductModel product) {
    var totalExpenses = product.quantity! * product.buyingPrice!;
    return totalExpenses;
  }

  getTotalExpenses(List<ProductModel> products) {
    var total = 0;
    for (var product in products) {
      var totalExpenses = product.quantity! * product.buyingPrice!;
      total += totalExpenses;
    }
    return total;
  }
}
