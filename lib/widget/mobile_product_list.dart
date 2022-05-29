import 'package:flutter/material.dart';
import '../model/product_model.dart';

class MobileProductList extends StatelessWidget {
  final List<ProductModel>? products;

  const MobileProductList({
    Key? key,
    this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return products!.isEmpty
        ? Text(
            "vous avez ${products!.length} dans votre inventaire",
          )
        : DataTable(
            columns: const [
              DataColumn(
                label: Text("nom"),
              ),
              DataColumn(
                label: Text("prix"),
              ),
              DataColumn(
                label: Text("status"),
              ),
            ],
            rows: products!
                .map(
                  (ProductModel productModel) => DataRow(
                    cells: [
                      DataCell(
                        InkWell(
                          onTap: () => Navigator.of(context).pushNamed(
                            '/product-detail',
                            arguments: productModel,
                          ),
                          child: Text(
                            productModel.name!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          productModel.initialPrice.toString(),
                        ),
                      ),
                      DataCell(
                        Text(
                          productModel.quantity! >= 1
                              ? "En stock"
                              : "En Rupture",
                          style: TextStyle(
                              color: productModel.quantity! >= 1
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          );
  }
}
