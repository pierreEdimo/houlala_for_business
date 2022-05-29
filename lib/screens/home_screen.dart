import 'package:flutter/material.dart';
import 'package:houlalaadministrator/constant/constants.dart';
import 'package:houlalaadministrator/model/page_model.dart';
import 'package:houlalaadministrator/widget/custom_card.dart';
import 'package:houlalaadministrator/widget/icon_box.dart';
import 'package:houlalaadministrator/widget/main_custom_container.dart';
import 'package:houlalaadministrator/widget/mobile_product_list.dart';
import 'package:houlalaadministrator/widget/order_list.dart';
import 'package:houlalaadministrator/widget/products_list.dart';
import 'package:houlalaadministrator/widget/title.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../widget/mobile_order_list.dart';

class HomeScreen extends StatelessWidget {
  final PageModel? pageModel;

  const HomeScreen({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      breakpoints: const ScreenBreakpoints(
        desktop: 1439,
        tablet: 1024,
        watch: 300,
      ),
      builder: (context, sizingInformation) {
        switch (sizingInformation.deviceScreenType) {
          case DeviceScreenType.mobile:
            return MobileHomeScreen(
              pageModel: pageModel,
            );
          case DeviceScreenType.tablet:
            return TabletHomeScreen(
              pageModel: pageModel,
            );
          case DeviceScreenType.desktop:
          default:
            return DesktopHomeScreen(
              pageModel: pageModel,
            );
        }
      },
    );
  }
}

class MobileHomeScreen extends StatelessWidget {
  final PageModel? pageModel;

  const MobileHomeScreen({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          standardVerticalSpace,
          const SafeArea(
            child: CustomTitle(
              title: "Dashboard",
              size: 22,
            ),
          ),
          standardVerticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconBox(
                        icon: Icons.shopping_basket_outlined,
                        color: Colors.green,
                        backgroundColor: Colors.green.shade50,
                      ),
                      standardVerticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const CustomTitle(
                            title: "Produits",
                            size: 18.0,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            pageModel!.productCount!.toString(),
                            style: const TextStyle(fontSize: 35.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              standardHorizontalSpace,
              Expanded(
                child: CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconBox(
                        icon: Icons.shopping_cart_checkout_outlined,
                        color: Colors.blue,
                        backgroundColor: Colors.blue.shade50,
                      ),
                      standardVerticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const CustomTitle(
                            title: "Ventes",
                            size: 18.0,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            pageModel!.successSold!.toString(),
                            style: const TextStyle(fontSize: 35.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          standardVerticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconBox(
                        icon: Icons.remove_shopping_cart_outlined,
                        color: Colors.red,
                        backgroundColor: Colors.red.shade50,
                      ),
                      standardVerticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const CustomTitle(
                            title: "Commandes annulees",
                            size: 18.0,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            pageModel!.canceled.toString(),
                            style: const TextStyle(fontSize: 35.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              standardHorizontalSpace,
              Expanded(
                child: CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconBox(
                        icon: Icons.shopping_cart_outlined,
                        color: Colors.orange,
                        backgroundColor: Colors.orange.shade50,
                      ),
                      standardVerticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const CustomTitle(
                            title: "Commandes recues",
                            size: 18.0,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            pageModel!.totalOrders!.toString(),
                            style: const TextStyle(fontSize: 35.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          standardVerticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomTitle(
                title: "Les Commandes recentes",
                size: 18.0,
              ),
              standardVerticalSpace,
              CustomCard(
                child: MobileOrderList(
                  msg: "commande(s) recues aujourdhui",
                  url:
                      'https://houlala.herokuapp.com/api/sent-orders/getSentOrdersByPageId?pageId=${pageModel!.id!}',
                ),
              )
            ],
          ),
          standardVerticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomTitle(
                title: "Les produits recents",
                size: 18.0,
              ),
              standardVerticalSpace,
              CustomCard(
                child: MobileProductList(
                  products: pageModel!.productLists,
                ),
              )
            ],
          ),
          standardVerticalSpace
        ],
      ),
    );
  }
}

class TabletHomeScreen extends StatelessWidget {
  final PageModel? pageModel;

  const TabletHomeScreen({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          standardVerticalSpace,
          const CustomTitle(
            title: "Dashboard",
            size: 22.0,
          ),
          standardVerticalSpace,
          GeneralInformation(
            pageModel: pageModel,
          ),
          standardVerticalSpace,
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CustomTitle(
                    title: "Les Commandes recentes",
                    size: 18.0,
                  ),
                  standardVerticalSpace,
                  CustomCard(
                    child: OrderList(
                      msg: "commande(s) recues aujourdhui",
                      url:
                          'https://houlala.herokuapp.com/api/sent-orders/getSentOrdersByPageId?pageId=${pageModel!.id!}',
                    ),
                  )
                ],
              ),
              standardVerticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CustomTitle(
                    title: "Les produits recents",
                    size: 18.0,
                  ),
                  standardVerticalSpace,
                  CustomCard(
                    child: ProductsLists(
                      products: pageModel!.productLists,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class DesktopHomeScreen extends StatelessWidget {
  final PageModel? pageModel;

  const DesktopHomeScreen({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          standardVerticalSpace,
          const CustomTitle(
            title: "Dashboard",
            size: 22.0,
          ),
          standardVerticalSpace,
          GeneralInformation(
            pageModel: pageModel,
          ),
          standardVerticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomTitle(
                      title: "Les produits recents",
                      size: 18.0,
                    ),
                    standardVerticalSpace,
                    CustomCard(
                      child: ProductsLists(
                        products: pageModel!.productLists,
                      ),
                    )
                  ],
                ),
              ),
              standardHorizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomTitle(
                      title: "Les Commandes recentes",
                      size: 18.0,
                    ),
                    standardVerticalSpace,
                    CustomCard(
                      child: OrderList(
                        msg: "commande(s) recues aujourdhui",
                        url:
                            'https://houlala.herokuapp.com/api/sent-orders/getSentOrdersByPageId?pageId=${pageModel!.id!}',
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          standardVerticalSpace
        ],
      ),
    );
  }
}

class GeneralInformation extends StatelessWidget {
  final PageModel? pageModel;

  const GeneralInformation({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconBox(
                  icon: Icons.shopping_basket_outlined,
                  color: Colors.green,
                  backgroundColor: Colors.green.shade50,
                ),
                standardVerticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomTitle(
                      title: "Produits",
                      size: 18.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      pageModel!.productCount!.toString(),
                      style: const TextStyle(fontSize: 35.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        standardHorizontalSpace,
        Expanded(
          child: CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconBox(
                  icon: Icons.shopping_cart_checkout_outlined,
                  color: Colors.blue,
                  backgroundColor: Colors.blue.shade50,
                ),
                standardVerticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomTitle(
                      title: "Ventes reussies",
                      size: 18.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      pageModel!.successSold!.toString(),
                      style: const TextStyle(fontSize: 35.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        standardHorizontalSpace,
        Expanded(
          child: CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconBox(
                  icon: Icons.remove_shopping_cart_outlined,
                  color: Colors.red,
                  backgroundColor: Colors.red.shade50,
                ),
                standardVerticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomTitle(
                      title: "Commandes annulees",
                      size: 18.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      pageModel!.canceled.toString(),
                      style: const TextStyle(fontSize: 35.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        standardHorizontalSpace,
        Expanded(
          child: CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconBox(
                  icon: Icons.shopping_cart_outlined,
                  color: Colors.orange,
                  backgroundColor: Colors.orange.shade50,
                ),
                standardVerticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomTitle(
                      title: "Commandes recues",
                      size: 18.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      pageModel!.totalOrders!.toString(),
                      style: const TextStyle(fontSize: 35.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
