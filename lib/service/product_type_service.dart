import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:houlalaadministrator/model/product_type.dart';
import 'package:http/http.dart';

class ProductTypeService extends ChangeNotifier{

  late String _subCategoryId;

  Future<List<ProductType>> fetchProductTypes() async {
    var url = Uri.parse('https://houlala.herokuapp.com/api/product-types');
    Response response = await get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<ProductType> productTypes = body
          .map((dynamic productType) => ProductType.fromJson(productType))
          .toList();
      return productTypes;
    } else {
      throw "No Product-Types";
    }
  }

  setSubCategoryId(String id){
    _subCategoryId = id;
  }

  getSubCategoryId(){
    return _subCategoryId;
  }
}