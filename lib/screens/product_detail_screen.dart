import 'package:flutter/material.dart';
import 'package:houlalaadministrator/constant/constants.dart';
import 'package:houlalaadministrator/model/product_model.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../widget/custom_card.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductModel productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
          ),
        ),
        title: Text(
          productModel.name!,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.more_vert_outlined,
              color: Colors.black,
            ),
          )
        ],
        backgroundColor: Colors.grey.shade200,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            switch (sizingInformation.deviceScreenType) {
              case DeviceScreenType.mobile:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: BodyScreen(
                    productModel: productModel,
                  ),
                );
              case DeviceScreenType.tablet:
                return Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: BodyScreen(
                        productModel: productModel,
                      ),
                    ),
                    const Spacer(),
                  ],
                );
              case DeviceScreenType.desktop:
              default:
                return Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: BodyScreen(
                        productModel: productModel,
                      ),
                    ),
                    const Spacer(),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}

class BodyScreen extends StatelessWidget {
  final ProductModel? productModel;

  const BodyScreen({
    Key? key,
    this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomCard(
              child: ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  switch (sizingInformation.deviceScreenType) {
                    case DeviceScreenType.mobile:
                      return SizedBox(
                        height: 250,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        productModel!.imageUrl!,
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            standardHorizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      const Text("Quantite:"),
                                      const Spacer(),
                                      Text(
                                        productModel!.quantity!.toString(),
                                      )
                                    ],
                                  ),
                                  standardVerticalSpace,
                                  Row(
                                    children: [
                                      const Text("Prix d'achat:"),
                                      const Spacer(),
                                      Text(
                                        '${productModel!.buyingPrice!} FCFA',
                                      )
                                    ],
                                  ),
                                  standardVerticalSpace,
                                  Row(
                                    children: [
                                      const Text("Prix de vente:"),
                                      const Spacer(),
                                      Text(
                                        '${productModel!.initialPrice!} FCFA',
                                      )
                                    ],
                                  ),
                                  standardVerticalSpace,
                                  Row(
                                    children: [
                                      const Text("Poids:"),
                                      const Spacer(),
                                      Text(
                                        '${productModel!.weight!} g',
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    case DeviceScreenType.tablet:
                    case DeviceScreenType.desktop:
                    default:
                      return SizedBox(
                        height: 350,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        productModel!.imageUrl!,
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            standardHorizontalSpace,
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      const Text("Quantite:"),
                                      const Spacer(),
                                      Text(
                                        productModel!.quantity!.toString(),
                                      )
                                    ],
                                  ),
                                  standardVerticalSpace,
                                  Row(
                                    children: [
                                      const Text("Prix d'achat:"),
                                      const Spacer(),
                                      Text(
                                        '${productModel!.buyingPrice!} FCFA',
                                      )
                                    ],
                                  ),
                                  standardVerticalSpace,
                                  Row(
                                    children: [
                                      const Text("Prix de vente:"),
                                      const Spacer(),
                                      Text(
                                        '${productModel!.initialPrice!} FCFA',
                                      )
                                    ],
                                  ),
                                  standardVerticalSpace,
                                  Row(
                                    children: [
                                      const Text("Poids:"),
                                      const Spacer(),
                                      Text(
                                        '${productModel!.weight!} g',
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                  }
                },
              ),
            ),
            standardVerticalSpace,
            CustomCard(
              child: Markdown(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                data: productModel!.description!,
              ),
            )
          ],
        ),
      ),
    );
  }
}
