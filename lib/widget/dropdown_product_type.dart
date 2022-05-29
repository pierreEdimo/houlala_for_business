import 'package:flutter/material.dart';
import 'package:houlalaadministrator/model/product_type.dart';
import 'package:houlalaadministrator/service/product_type_service.dart';
import 'package:provider/provider.dart';

class DropdownProductType extends StatefulWidget {
  const DropdownProductType({Key? key}) : super(key: key);

  @override
  State<DropdownProductType> createState() => _DropdownProductTypeState();
}

class _DropdownProductTypeState extends State<DropdownProductType> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ProductTypeService>(context).fetchProductTypes(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductType>> snapshot) {
        if (snapshot.hasData) {
          List<ProductType>? productTypes = snapshot.data;

          return DropdownButtonFormField<ProductType>(
            decoration: const InputDecoration(
              border: OutlineInputBorder()
            ),
            hint: const Text("sous-categorie"),
            items: productTypes!
                .map<DropdownMenuItem<ProductType>>((ProductType productType) {
              return DropdownMenuItem<ProductType>(
                value: productType,
                child: Text(productType.label!),
              );
            }).toList(),
            onChanged: (value) {
              Provider.of<ProductTypeService>(context, listen: false)
                  .setSubCategoryId(value!.id!);
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
