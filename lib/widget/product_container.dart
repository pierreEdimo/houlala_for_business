import 'package:flutter/material.dart';
import 'package:houlalaadministrator/model/product_model.dart';

class ProductContainer extends StatelessWidget {
  final ProductModel? productModel;

  const ProductContainer({
    Key? key,
    this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: Colors.transparent,
        child: Center(
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const <int, TableColumnWidth>{
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              4: FlexColumnWidth()
            },
            children: [
              TableRow(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                          image: NetworkImage(
                            productModel!.imageUrl!,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Center(
                    child: Text(
                      productModel!.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${productModel!.initialPrice!.toString()} FCFA',
                    ),
                  ),
                  Center(
                    child: Text(
                      'X ${productModel!.quantity!.toString()}',
                    ),
                  ),
                  Center(
                    child: Text(
                      productModel!.quantity! >= 1
                          ? "Disponible"
                          : "en Rupture",
                      style: TextStyle(
                          color: productModel!.quantity! >= 1
                              ? Colors.green
                              : Colors.red),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
