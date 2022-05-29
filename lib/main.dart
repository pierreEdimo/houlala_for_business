import 'package:flutter/material.dart';
import 'package:houlalaadministrator/constant/boxes.dart';
import 'package:houlalaadministrator/screens/add_post_screen.dart';
import 'package:houlalaadministrator/screens/add_product_screen.dart';
import 'package:houlalaadministrator/screens/dashboard_screen.dart';
import 'package:houlalaadministrator/screens/login_screen.dart';
import 'package:houlalaadministrator/screens/order_detail_screen.dart';
import 'package:houlalaadministrator/screens/product_detail_screen.dart';
import 'package:houlalaadministrator/service/category_service.dart';
import 'package:houlalaadministrator/service/login_service.dart';
import 'package:houlalaadministrator/service/order_service.dart';
import 'package:houlalaadministrator/service/page_service.dart';
import 'package:houlalaadministrator/service/post_service.dart';
import 'package:houlalaadministrator/service/product_type_service.dart';
import 'package:houlalaadministrator/service/product_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('userId');

  initializeDateFormatting('fr', null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _userBox = HiveBoxes.getUserId();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginService()),
        ChangeNotifierProvider(create: (context) => PageService()),
        ChangeNotifierProvider(create: (context) => OrderService()),
        ChangeNotifierProvider(create: (context) => ProductService()),
        ChangeNotifierProvider(create: (context) => CategoryService()),
        ChangeNotifierProvider(create: (context) => ProductTypeService()),
        ChangeNotifierProvider(create: (context) => PostService()),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Poppins'
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => _userBox.get("loggedState") == "loggedIn"
                ? const DashboardScreen()
                : LoginScreen(),
            '/dashboard': (context) => const DashboardScreen(),
            '/addProduct': (context) => const AddProductScreen(),
            '/addPost': (context) => const AddPostScreen(),
            '/product-detail':(context) => const ProductDetailScreen(),
            '/order-detail':(context) => const OrderDetailScreen()
          },
        );
      },
    );
  }
}
