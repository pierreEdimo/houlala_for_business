import 'package:flutter/material.dart';
import 'package:houlalaadministrator/constant/constants.dart';
import 'package:houlalaadministrator/model/page_model.dart';
import 'package:houlalaadministrator/widget/mobile_order_list.dart';
import 'package:houlalaadministrator/widget/order_list.dart';
import 'package:houlalaadministrator/widget/title.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../widget/custom_card.dart';

class OrderScreen extends StatelessWidget {
  final PageModel? pageModel;

  const OrderScreen({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        breakpoints: const ScreenBreakpoints(
          desktop: 1280,
          tablet: 1024,
          watch: 300,
        ),
        builder: (context, sizeInformation) {
          switch (sizeInformation.deviceScreenType) {
            case DeviceScreenType.mobile:
              return MobileOrderScreen(
                pageModel: pageModel,
              );
            case DeviceScreenType.tablet:
              return TabletOrderScreen(
                pageModel: pageModel,
              );
            case DeviceScreenType.desktop:
            default:
              return DesktopOrderScreen(
                pageModel: pageModel,
              );
          }
        });
  }
}

class MobileOrderScreen extends StatefulWidget {
  final PageModel? pageModel;

  const MobileOrderScreen({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  State<MobileOrderScreen> createState() => _MobileOrderScreenState();
}

class _MobileOrderScreenState extends State<MobileOrderScreen> {
  late bool _isSelected = false;
  late int _currentIndex = 0;

  late List<String> menus = [
    "Tous",
    "En Attente",
    "En Route",
    "Delivre",
    "Annule",
  ];

  @override
  Widget build(BuildContext context) {
    late List<Widget> widgetBodies = [
      MobileOrderList(
        msg: "Commande(s) en tout",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/getAllSentOrdersFromPageId?pageId=${widget.pageModel!.id}',
      ),
      MobileOrderList(
        msg: "Commande(s) en Attente",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/filterOrderByStatus?pageId=${widget.pageModel!.id}&status=Attente',
      ),
      MobileOrderList(
        msg: "Commande(s) en Route",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/filterOrderByStatus?pageId=${widget.pageModel!.id}&status=En%20Route',
      ),
      MobileOrderList(
        msg: "Commande(s) delivre",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/filterOrderByStatus?pageId=${widget.pageModel!.id}&status=Delivre',
      ),
      MobileOrderList(
        msg: "Commande(s) annulee",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/filterOrderByStatus?pageId=${widget.pageModel!.id}&status=Annule',
      )
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        standardVerticalSpace,
        const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomTitle(
              title: "Commandes",
              size: 22.0,
            ),
          ),
        ),
        SizedBox(
          height: 70.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: menus.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                _isSelected = _currentIndex == index;
                String menu = menus[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: Container(
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: _isSelected
                          ? const Border(
                              bottom: BorderSide(
                                  width: 2, color: Color(0xffdf972f)))
                          : const Border(
                              bottom: BorderSide(
                                  width: 0, color: Colors.transparent),
                            ),
                    ),
                    child: Text(
                      menu,
                      style: TextStyle(
                          color: _isSelected
                              ? const Color(0xffdf972f)
                              : const Color(0xff000000)),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            bottom: 30.0,
          ),
          child: CustomCard(
            child: widgetBodies.elementAt(_currentIndex),
          ),
        )
      ],
    );
  }
}

class TabletOrderScreen extends StatefulWidget {
  final PageModel? pageModel;

  const TabletOrderScreen({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  State<TabletOrderScreen> createState() => _TabletOrderScreenState();
}

class _TabletOrderScreenState extends State<TabletOrderScreen> {
  late bool _isSelected = false;
  late int _currentIndex = 0;

  late List<String> menus = [
    "Tous",
    "En Attente",
    "En Route",
    "Delivre",
    "Annule",
  ];

  @override
  Widget build(BuildContext context) {
    late List<Widget> widgetBodies = [
      OrderList(
        msg: "Commande(s) en tout",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/getAllSentOrdersFromPageId?pageId=${widget.pageModel!.id}',
      ),
      OrderList(
        msg: "Commande(s) en Attente",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/filterOrderByStatus?pageId=${widget.pageModel!.id}&status=Attente',
      ),
      OrderList(
        msg: "Commande(s) en Route",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/filterOrderByStatus?pageId=${widget.pageModel!.id}&status=En%20Route',
      ),
      OrderList(
        msg: "Commande(s) delivre",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/filterOrderByStatus?pageId=${widget.pageModel!.id}&status=Delivre',
      ),
      OrderList(
        msg: "Commande(s) annulee",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/filterOrderByStatus?pageId=${widget.pageModel!.id}&status=Annule',
      )
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        standardVerticalSpace,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomTitle(
            title: "Commandes",
            size: 22.0,
          ),
        ),
        SizedBox(
          height: 70.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: menus.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                _isSelected = _currentIndex == index;
                String menu = menus[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: Container(
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: _isSelected
                          ? const Border(
                              bottom: BorderSide(
                                  width: 2, color: Color(0xffdf972f)))
                          : const Border(
                              bottom: BorderSide(
                                  width: 0, color: Colors.transparent),
                            ),
                    ),
                    child: Text(
                      menu,
                      style: TextStyle(
                          color: _isSelected
                              ? const Color(0xffdf972f)
                              : const Color(0xff000000)),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomCard(
            child: widgetBodies.elementAt(_currentIndex),
          ),
        )
      ],
    );
  }
}

class DesktopOrderScreen extends StatefulWidget {
  final PageModel? pageModel;

  const DesktopOrderScreen({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  State<DesktopOrderScreen> createState() => _DesktopOrderScreenState();
}

class _DesktopOrderScreenState extends State<DesktopOrderScreen> {
  late bool _isSelected = false;
  late int _currentIndex = 0;

  late List<String> menus = [
    "Tous",
    "En Attente",
    "En Route",
    "Delivre",
    "Annule",
  ];

  @override
  Widget build(BuildContext context) {
    late List<Widget> widgetBodies = [
      OrderList(
        msg: "Commande(s) en tout",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/getAllSentOrdersFromPageId?pageId=${widget.pageModel!.id}',
      ),
      OrderList(
        msg: "Commande(s) en Attente",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/filterOrderByStatus?pageId=${widget.pageModel!.id}&status=Attente',
      ),
      OrderList(
        msg: "Commande(s) en Route",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/filterOrderByStatus?pageId=${widget.pageModel!.id}&status=En%20Route',
      ),
      OrderList(
        msg: "Commande(s) delivre",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/filterOrderByStatus?pageId=${widget.pageModel!.id}&status=Delivre',
      ),
      OrderList(
        msg: "Commande(s) annulee",
        url:
            'https://houlala.herokuapp.com/api/sent-orders/filterOrderByStatus?pageId=${widget.pageModel!.id}&status=Annule',
      )
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        standardVerticalSpace,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomTitle(
            title: "Commandes",
            size: 22.0,
          ),
        ),
        SizedBox(
          height: 70.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: menus.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                _isSelected = _currentIndex == index;
                String menu = menus[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: Container(
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: _isSelected
                          ? const Border(
                              bottom: BorderSide(
                                  width: 2, color: Color(0xffdf972f)))
                          : const Border(
                              bottom: BorderSide(
                                  width: 0, color: Colors.transparent),
                            ),
                    ),
                    child: Text(
                      menu,
                      style: TextStyle(
                          color: _isSelected
                              ? const Color(0xffdf972f)
                              : const Color(0xff000000)),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: CustomCard(
                  child: widgetBodies.elementAt(_currentIndex),
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
                          const Text("Nombre total de commende"),
                          standardHorizontalSpace,
                          Text(widget.pageModel!.totalOrders.toString())
                        ],
                      ),
                      standardVerticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Nombre total de delivrees"),
                          standardHorizontalSpace,
                          Text(widget.pageModel!.successSold.toString())
                        ],
                      ),
                      standardVerticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Nombre de Commandes annulees"),
                          standardHorizontalSpace,
                          Text(widget.pageModel!.canceled.toString())
                        ],
                      ),
                      standardVerticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Nombre de Commandes en Attente"),
                          standardHorizontalSpace,
                          Text(widget.pageModel!.pendingOrderCount.toString())
                        ],
                      ),
                      standardVerticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Nombre de commandes en Route"),
                          standardHorizontalSpace,
                          Text(widget.pageModel!.orderUnderWay.toString())
                        ],
                      ),
                      standardVerticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Revenu approximatif"),
                          standardHorizontalSpace,
                          Text(widget.pageModel!.approxRevenue.toString())
                        ],
                      ),
                      standardVerticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Revenu realise sur les Ventes"),
                          standardHorizontalSpace,
                          Text(
                            widget.pageModel!.totalRevenueFromSell.toString(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
