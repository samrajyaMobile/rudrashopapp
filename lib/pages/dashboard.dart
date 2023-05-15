// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rudrashop/http/model/add_to_cart_model.dart';
import 'package:rudrashop/pages/cart.dart';
import 'package:rudrashop/pages/home.dart';
import 'package:rudrashop/pages/my_biz.dart';

import 'package:rudrashop/pages/settings.dart';
import 'package:rudrashop/pages/sub_categoty.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardModel>(
      builder: (context, dashboard, _) {
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(canvasColor: AppColor.white),
              child: BottomNavigationBar(
                elevation: 0,
                onTap: (int pageIndex) {
                  dashboard.changePage(pageIndex);
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColor.mainColor,
                currentIndex: dashboard._currentPage,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.call),
                    label: "Chat",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.card_travel),
                    label: "My Biz",
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColor.mainColor,
              title: Text("Samrajya"),
              actions: [
                IconButton(
                    onPressed: () async {
                      var nav = await Navigator.push(context, MaterialPageRoute(builder: (context) => const Cart()));

                      if (nav != null) {
                        dashboard.getCartData();
                      }
                    },
                    icon: const Icon(Icons.shopping_cart))
              ],
            ),
            body: Column(
              children: [
                Expanded(child: dashboard.pages[dashboard._currentPage])
              ],
            ),
          ),
        );
      },
    );
  }
}

class DashboardModel extends ChangeNotifier {
  int _currentPage = 1;
  List<AddToCartModel> cartList = [];

  var pages = [
    Home(),
    Home(),
    MyBiz(),
  ];
  var page;

  changePage(int index) {
    _currentPage = index;

    notifyListeners();
  }

  getCartData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? strData = (preferences.getString(SharedPrefConstant.CART_LIST) ?? "");
    if (strData != "") {
      var jsonData = json.decode(strData);
      var list = List<dynamic>.from(jsonData);
      cartList = list.map((e) => AddToCartModel.fromJson(e)).toList();
      notifyListeners();
    }
  }
}

