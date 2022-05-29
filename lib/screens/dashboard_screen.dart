import 'package:flutter/material.dart';
import 'package:houlalaadministrator/screens/inventory_screen.dart';
import 'package:houlalaadministrator/screens/orders_screen.dart';
import 'package:houlalaadministrator/screens/post_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../model/page_model.dart';
import '../service/page_service.dart';
import '../widget/main_navigation.dart';
import 'home_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<PageService>(context).getSinglePage(),
      builder: (BuildContext context, AsyncSnapshot<PageModel> snapshot) {
        if (snapshot.hasData) {
          PageModel? pageModel = snapshot.data!;

          return ResponsiveBuilder(

            builder: (context, sizingInformation) {
              switch (sizingInformation.deviceScreenType) {
                case DeviceScreenType.mobile:
                case DeviceScreenType.tablet:
                  return BottomNavDashboardScreen(
                    pageModel: pageModel,
                  );
                case DeviceScreenType.desktop:
                default:
                  return DesktopDashboardScreen(
                    pageModel: pageModel,
                  );
              }
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

class DesktopDashboardScreen extends StatelessWidget {
  final PageModel? pageModel;

  const DesktopDashboardScreen({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.home_outlined,
      Icons.shopping_bag_outlined,
      Icons.inventory_outlined,
      Icons.newspaper_outlined,
    ];

    return MainNavigation(
      menuItems: icons,
      widgetOptions: [
        HomeScreen(
          pageModel: pageModel,
        ),
        OrderScreen(
          pageModel: pageModel,
        ),
        InventoryScreen(
          pageModel: pageModel,
        ),
        PostScreen(
          pageModel: pageModel,
        ),
      ],
    );
  }
}

class BottomNavDashboardScreen extends StatefulWidget {
  final PageModel? pageModel;

  const BottomNavDashboardScreen({
    Key? key,
    this.pageModel,
  }) : super(key: key);

  @override
  State<BottomNavDashboardScreen> createState() =>
      _BottomNavDashboardScreenState();
}

class _BottomNavDashboardScreenState extends State<BottomNavDashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      HomeScreen(
        pageModel: widget.pageModel,
      ),
      PostScreen(
        pageModel: widget.pageModel,
      ),
      OrderScreen(
        pageModel: widget.pageModel,
      ),
      InventoryScreen(
        pageModel: widget.pageModel,
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_outlined),
            label: 'Annonces',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Commandes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_outlined),
            label: 'Produits',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xffdf972f),
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: const Color(0xff000000),
      ),
    );
  }
}

/**
 *
 */
