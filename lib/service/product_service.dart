import 'package:flutter/material.dart';
import 'package:houlalaadministrator/model/add_product.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class ProductService extends ChangeNotifier {
  late final ImagePicker _picker = ImagePicker();
  XFile? imageFile;

  Future<void> addProduct(XFile filepath, AddProduct newProduct) async {
    var request = MultipartRequest(
        'POST', Uri.parse('https://houlala.herokuapp.com/api/products'));
    request.fields['name'] = newProduct.name!;
    request.fields['description'] = newProduct.description!;
    request.fields['weight'] = newProduct.weight!.toString();
    request.fields['initialPrice'] = newProduct.sellingPrice.toString();
    request.fields['buyingPrice'] = newProduct.buyingPrice.toString();
    request.fields['quantity'] = newProduct.quantity.toString();
    request.fields['page'] = newProduct.pageId!;
    request.fields['categoryId'] = newProduct.categoryId!;
    request.fields['productType'] = newProduct.productType!;
    request.files.add(
      MultipartFile.fromBytes('image', await filepath.readAsBytes(),
          filename: filepath.name),
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
