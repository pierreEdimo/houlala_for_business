import 'package:flutter/material.dart';
import 'package:houlalaadministrator/constant/constants.dart';
import 'package:houlalaadministrator/model/cart_item.dart';
import 'package:houlalaadministrator/model/order_model.dart';
import 'package:houlalaadministrator/widget/custom_card.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Order order = ModalRoute.of(context)!.settings.arguments as Order;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Nummero de Commandes: 101',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade200,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            switch (sizingInformation.deviceScreenType) {
              case DeviceScreenType.mobile:
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 30.0,
                  ),
                  child: BodyScreen(
                    order: order,
                  ),
                );
              case DeviceScreenType.tablet:
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.70,
                        child: BodyScreen(
                          order: order,
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                );
              case DeviceScreenType.desktop:
              default:
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: BodyScreen(
                          order: order,
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

class BodyScreen extends StatelessWidget {
  final Order? order;

  const BodyScreen({
    Key? key,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List<CartItem> items = order!.cartItems!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCard(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${order!.userInformation!.firstName} ${order!.userInformation!.lastName}",
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "${order!.address!.streetName!}, ${order!.address!.city!}",
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  order!.address!.country!,
                )
              ],
            ),
          ),
        ),
        standardVerticalSpace,
        CustomCard(
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: items
                .map(
                  (CartItem item) => ResponsiveBuilder(
                    builder: (context, sizingInformation) {
                      switch (sizingInformation.deviceScreenType) {
                        case DeviceScreenType.mobile:
                          return Card(
                            color: Colors.transparent,
                            elevation: 0,
                            child: SizedBox(
                              height: 200,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  item.product!.imageUrl!),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  standardHorizontalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            item.product!.name!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Text("quantite: "),
                                            Text(
                                              item.quantity.toString(),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text("prix: "),
                                            Text(
                                              item.totalPrice.toString(),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        case DeviceScreenType.tablet:
                        case DeviceScreenType.desktop:
                        default:
                        return Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: SizedBox(
                            height: 250,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                item.product!.imageUrl!),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                standardHorizontalSpace,
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          item.product!.name!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Text("quantite: "),
                                          Text(
                                            item.quantity.toString(),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("prix: "),
                                          Text(
                                            item.totalPrice.toString(),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                )
                .toList(),
          ),
        ),
        standardVerticalSpace,
        CustomCard(
          child: Row(
            children: [
              const Text("Prix Total: "),
              Text('${order!.totalPrice!} FCFA')
            ],
          ),
        )
      ],
    );
  }
}
