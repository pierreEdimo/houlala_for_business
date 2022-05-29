import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:houlalaadministrator/constant/boxes.dart';
import 'package:http/http.dart';

import '../model/login_model.dart';

class LoginService extends ChangeNotifier {
  final _userIdBox = HiveBoxes.getUserId();

  void logout(BuildContext context){
    _userIdBox.put("userId", null);
    _userIdBox.put("loggedState", null);
    Navigator.of(context).pop('/');
    notifyListeners();
  }

  Future<Response> logIn(LoginModel loginModel) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsEncode;
    jsEncode = jsonEncode(loginModel);

    var url =
        Uri.parse('https://houlala.herokuapp.com/api/authentication/login');
    final Response response = await post(
      url,
      headers: headers,
      body: jsEncode,
    );

    if (response.statusCode == 201) {
      final responseJson = json.decode(response.body);
      _userIdBox.put("userId", responseJson['user']['_id']);
      _userIdBox.put("loggedState", "loggedIn");
      notifyListeners();
    }
    return response;
  }
}
