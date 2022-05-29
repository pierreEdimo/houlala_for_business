
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../model/category_model.dart';

class CategoryService extends ChangeNotifier{
  late String _categoryId ;

  Future<List<CategoryModel>> fetchAllCategories() async {
    var url = Uri.parse('https://houlala.herokuapp.com/api/categories');
    Response response = await get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<CategoryModel> categories = body
          .map((dynamic category) => CategoryModel.fromJson(category))
          .toList();
      return categories;
    } else {
      throw "No Categories";
    }
  }

  setCategorId(String id){
    _categoryId = id;
    notifyListeners();
  }

  getCategoryId(){
    return _categoryId;
  }
}