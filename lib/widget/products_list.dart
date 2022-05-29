import 'package:flutter/material.dart';
import '../model/product_model.dart';

class ProductsLists extends StatelessWidget {
  final List<ProductModel>? products;

  const ProductsLists({
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
                label: Text("qte"),
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
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: InkWell(
                            onTap: () => Navigator.of(context).pushNamed(
                              '/product-detail',
                              arguments: productModel
                            ),
                            child: Text(
                              productModel.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
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
                          productModel.quantity.toString(),
                        ),
                      ),
                      DataCell(
                        Text(
                          productModel.quantity! >= 1
                              ? "Disponible"
                              : "en Rupture",
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
