// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:rudrashop/pages/home.dart';
import 'package:rudrashop/pages/settings.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:provider/provider.dart';

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
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
                ],
              ),
            ),
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: AppColor.mainColor,
              title: Image.asset(
                "assets/images/logo.png",
                scale: 12,
              ),
            ),
            body: dashboard.page ?? dashboard.pages[dashboard._currentPage],
          ),
        );
      },
    );
  }
}

class DashboardModel extends ChangeNotifier {
  int _currentPage = 1;

  final List pages = [const Settings(), const Home(), const Home()];
  var page;

  changePage(int index) {
    _currentPage = index;
    page = pages[_currentPage];
    notifyListeners();
  }
}
