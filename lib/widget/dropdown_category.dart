import 'package:flutter/material.dart';
import 'package:houlalaadministrator/model/category_model.dart';
import 'package:houlalaadministrator/service/category_service.dart';
import 'package:provider/provider.dart';

class DropdownCategory extends StatelessWidget {
  const DropdownCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<CategoryService>(context).fetchAllCategories(),
      builder:
          (BuildContext context, AsyncSnapshot<List<CategoryModel>> snapshot) {
        if (snapshot.hasData) {
          List<CategoryModel>? categories = snapshot.data;

          return DropdownButtonFormField<CategoryModel>(
            decoration: const InputDecoration(
              border: OutlineInputBorder()
            ),
              hint: const Text("categorie "),
              items: categories!.map<DropdownMenuItem<CategoryModel>>(
                  (CategoryModel categoryModel) {
                return DropdownMenuItem<CategoryModel>(
                  value: categoryModel,
                  child: Text(categoryModel.name!),
                );
              }).toList(),
              onChanged: (value) {
                String categoryId = value!.id!;
                Provider.of<CategoryService>(context, listen: false)
                    .setCategorId(categoryId);
              });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
