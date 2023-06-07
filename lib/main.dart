import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/http/model/version_code_response.dart';
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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
late FirebaseMessaging messaging;
final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

void notificationTapBackground(NotificationResponse notificationResponse) {
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print('notification action tapped with input: ${notificationResponse.input}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  //If subscribe based on topic then use this
  await messaging.subscribeToTopic('flutter_notification');

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      "samrajya_app",
      "samrajya_app_channel",
      importance: Importance.max,
      enableLights: true,
      enableVibration: true,
      showBadge: true,
      playSound: true,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin!.initialize(initSettings,
        onDidReceiveNotificationResponse: notificationTapBackground, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        routes: {
          "/dashboard": (context) => const Dashboard(),
          "/login": (context) => const LoginScreen(),
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
    getVersion();
    super.initState();
  }

  getVersion() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    signedIn = sharedPreferences.getBool(SharedPrefConstant.U_LOGIN) ?? false;
    var response = await http.post(
      Uri.parse(
        "https://samrajya.co.in/index.php/wp-json/custom/v1/app-version?consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637",
      ),
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      var data = VersionCodeResponse.fromJson(jsonData);

      if (Platform.isAndroid) {
        String android;
        android = packageInfo.version;

        if (data.data!.first.android != android) {
          final url = "https://play.google.com/store/apps/details?id=${packageInfo.packageName}";
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            );
          }
        } else {
          navigation();
        }
      } else if (Platform.isIOS) {
        String ios;
        ios = packageInfo.version;
        if (data.data!.first.ios == ios) {
          String url = data.data?.first.appstoreurl ?? "";
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            );
          }
        }
      } else {
        navigation();
      }
    }
  }

  navigation() async {
    Timer(const Duration(seconds: 3), () {
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
    });
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
