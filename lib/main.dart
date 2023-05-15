// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/pages/addresses.dart';
import 'package:rudrashop/pages/all_category.dart';
import 'package:rudrashop/pages/dashboard.dart';
import 'package:rudrashop/pages/home.dart';
import 'package:rudrashop/pages/login_screen.dart';
import 'package:rudrashop/pages/my_biz.dart';
import 'package:rudrashop/pages/orders_list.dart';
import 'package:rudrashop/pages/products_details.dart';
import 'package:rudrashop/pages/profile.dart';
import 'package:rudrashop/pages/sub_categoty.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        ChangeNotifierProvider(create: (context) => LoginModel()),
        ChangeNotifierProvider(create: (context) => SubCategoryModel()),
        ChangeNotifierProvider(create: (context) => ProductsDetailsModel()),
        ChangeNotifierProvider(create: (context) => HomeModel()),
        ChangeNotifierProvider(create: (context) => AllCategoryModel()),
        ChangeNotifierProvider(create: (context) => ProfileModel()),
        ChangeNotifierProvider(create: (context) => OrdersModal()),
        ChangeNotifierProvider(create: (context) => AddressModel()),
        ChangeNotifierProvider(create: (context) => MyBizModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        routes: {
          "/dashboard" : (context) => const Dashboard(),
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool signedIn = false;

  @override
  void initState() {
    navigation();
    super.initState();
  }

  navigation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    signedIn = sharedPreferences.getBool(SharedPrefConstant.U_LOGIN) ?? false;

    if (signedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Dashboard(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.mainColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              "assets/images/logoimage.png",
              scale: 2,
            ))
          ],
        ),
      ),
    );
  }
}
