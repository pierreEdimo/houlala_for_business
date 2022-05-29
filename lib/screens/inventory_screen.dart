import 'package:flutter/material.dart';
import 'package:houlalaadministrator/constant/constants.dart';
import 'package:houlalaadministrator/model/page_model.dart';
import 'package:houlalaadministrator/service/page_service.dart';
import 'package:houlalaadministrator/widget/custom_card.dart';
import 'package:houlalaadministrator/widget/mobile_product_list.dart';
import 'package:houlalaadministrator/widget/products_list.dart';
import 'package:houlalaadministrator/widget/title.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class InventoryScreen extends StatelessWidget {
  final PageModel? pageModel;

  const InventoryScreen({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      breakpoints: const ScreenBreakpoints(
        desktop: 1024,
        tablet: 729,
        watch: 300,
      ),
      builder: (context, sizingInformation) {
        switch (sizingInformation.deviceScreenType) {
          case DeviceScreenType.mobile:
          case DeviceScreenType.tablet:
            return MobileInventoryScreen(
              pageModel: pageModel,
            );
          case DeviceScreenType.desktop:
          default:
            return DesktopInventoryScreen(
              pageModel: pageModel,
            );
        }
      },
    );
  }
}

class MobileInventoryScreen extends StatelessWidget {
  final PageModel? pageModel;

  const MobileInventoryScreen({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            standardVerticalSpace,
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTitle(
                    title: "Produits",
                    size: 22.0,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .pushNamed('/addProduct', arguments: pageModel!.id!),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Row(
                        children: const [
                          Icon(Icons.add),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Ajouter un Produit",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            standardVerticalSpace,
            CustomCard(
              child: MobileProductList(
                products: pageModel!.productLists,
              ),
            ),
            standardVerticalSpace,
          ],
        ),
      ),
    );
  }
}

class DesktopInventoryScreen extends StatelessWidget {
  final PageModel? pageModel;

  const DesktopInventoryScreen({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                standardVerticalSpace,
                const CustomTitle(
                  title: "Produits",
                  size: 22.0,
                ),
                standardVerticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomCard(
                        child: ProductsLists(
                          products: pageModel!.productLists,
                        ),
                      ),
                    ),
                    standardHorizontalSpace,
                    Expanded(
                      child: CustomCard(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Nombre Total de produits"),
                                Text(pageModel!.productCount.toString())
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () => Navigator.of(context)
              .pushNamed('/addProduct', arguments: pageModel!.id!),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(5.0)),
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: const Text("Ajouter un produit"),
          ),
        ),
      ),
    );
  }
}
