import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/pages/deal_products.dart';
import 'package:rudrashop/pages/home.dart';
import 'package:rudrashop/pages/dashboard.dart';
import 'package:rudrashop/pages/login_screen.dart';
import 'package:rudrashop/pages/main_products_list.dart';
import 'package:rudrashop/pages/new_arrivals_products.dart';
import 'package:rudrashop/pages/products_details.dart';
import 'package:rudrashop/pages/signup.dart';
import 'package:rudrashop/pages/sub3_category.dart';
import 'package:rudrashop/pages/sub_categoty.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashboardModel()),
        ChangeNotifierProvider(create: (context) => HomeModel()),
        ChangeNotifierProvider(create: (context) => LoginModel()),
        ChangeNotifierProvider(create: (context) => SubCategoryModel()),
        ChangeNotifierProvider(create: (context) => Sub3CategoryModel()),
        ChangeNotifierProvider(create: (context) => MainProductsListModel()),
        ChangeNotifierProvider(create: (context) => ProductsDetailsModel()),
        ChangeNotifierProvider(create: (context) => NewArrivalsProductsModel()),
        ChangeNotifierProvider(create: (context) => DealProductsModel()),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
