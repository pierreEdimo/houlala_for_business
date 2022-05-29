import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:houlalaadministrator/model/add_post.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class PostService extends ChangeNotifier {
  late final ImagePicker _picker = ImagePicker();
  XFile? imageFile;

  Future<void> addPostWithoutImage(AddPost newPost) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsEncode;
    jsEncode = jsonEncode(newPost);
    var url = Uri.parse('https://houlala.herokuapp.com/api/posts');
    await post(
      url,
      headers: headers,
      body: jsEncode,
    );
    notifyListeners();
  }

  Future<void> addPostWithImage(XFile filepath, AddPost newPost) async {
    var request = MultipartRequest(
      'POST',
      Uri.parse('https://houlala.herokuapp.com/api/posts/postWithImage'),
    );
    request.fields['content'] = newPost.content!;
    request.fields['page'] = newPost.pageId!;
    request.files.add(
      MultipartFile.fromBytes(
        'image',
        await filepath.readAsBytes(),
        filename: filepath.name,
      ),
    );
    await request.send();
    notifyListeners();
  }

  void pickImage() async {
    try {
      imageFile = (await _picker.pickImage(source: ImageSource.gallery))!;
      notifyListeners();
    } catch (e) {
      throw "Image picker error $e";
    }
  }

  getImageFile() {
    return imageFile;
  }
}
