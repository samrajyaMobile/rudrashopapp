// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rudrashop/pages/dashboard.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_dialog.dart';
import 'package:rudrashop/utils/app_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<LoginModel>(builder: (context, login, _) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.white,
          body: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text("Enter Login Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: login._email,
                      style: AppFonts.textFieldBlack,
                      decoration: InputDecoration(
                        label: const Text("E-mail"),
                        labelStyle: AppFonts.textFieldLabelGary,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: login._password,
                      obscureText: true,
                      style: AppFonts.textFieldBlack,
                      decoration: InputDecoration(
                        label: const Text("Password"),
                        labelStyle: AppFonts.textFieldLabelGary,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                const Row(
                  children: [
                    Text(
                      "By continuing, you agree to",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text("Terms of use", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                    Text(" & ", style: TextStyle(fontSize: 10)),
                    Text("Privacy policy", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/safe.svg",
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      "assets/images/datasafe.svg",
                      height: 30,
                      width: 30,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                (login._email.text.isNotEmpty)
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              backgroundColor: MaterialStateProperty.all(AppColor.mainColor),
                              overlayColor: MaterialStateProperty.all(Colors.white10),
                            ),
                            onPressed: () {
                              login.validator(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                "Login",
                              ),
                            )),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              backgroundColor: MaterialStateProperty.all(Colors.grey),
                              overlayColor: MaterialStateProperty.all(Colors.white10),
                            ),
                            onPressed: () {
                              login.validator(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                "Login",
                              ),
                            )),
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class LoginModel extends ChangeNotifier {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  validator(BuildContext context) {
    if (_email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your Email Address")));
    } else if (_password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your Password")));
    } else {
      login(context);
    }
  }

  login(BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String uEmail = _email.text.toLowerCase().trim();
    String uPassword = _password.text.trim();

    var map = {
      "username": uEmail,
      "password": uPassword,
    };

    var response = await http.post(
        Uri.parse(
            "https://samrajya.co.in/index.php/wp-json/custom-woocommerce-api/v1/login?consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637"),
        body: json.encode(map));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      if (jsonData["status"] == "success") {
        sharedPreferences.setBool(SharedPrefConstant.U_LOGIN, true);
        sharedPreferences.setString(SharedPrefConstant.U_ID, jsonData["user_id"].toString());
        sharedPreferences.setString(SharedPrefConstant.U_EMAIL, jsonData["email_address"].toString());
        sharedPreferences.setString(SharedPrefConstant.U_FIRST_NAME, jsonData["first_name"].toString());
        sharedPreferences.setString(SharedPrefConstant.U_LAST_NAME, jsonData["last_name"].toString());
        sharedPreferences.setString(SharedPrefConstant.U_GST, jsonData["billing_gst"].toString());
        sharedPreferences.setString(SharedPrefConstant.U_BUSINESS_NAME, jsonData["company_name"].toString());
        sharedPreferences.setString(SharedPrefConstant.U_MO_NUMBER, jsonData["mobile_phone"].toString());
        sharedPreferences.setString(SharedPrefConstant.U_ADDRESS1, jsonData["address_1"].toString());
        sharedPreferences.setString(SharedPrefConstant.U_ADDRESS2, jsonData["address_2"].toString());
        sharedPreferences.setString(SharedPrefConstant.U_CITY, jsonData["city"].toString());
        sharedPreferences.setString(SharedPrefConstant.U_PIN, jsonData["pincode"].toString());
        sharedPreferences.setString(SharedPrefConstant.U_STATE, jsonData["state"].toString());
        sharedPreferences.setString(SharedPrefConstant.U_AVATAR, jsonData["profile_picture"].toString());
        sharedPreferences.setString(SharedPrefConstant.U_DISPLAY_NAME, jsonData["display_name"].toString());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter correct credential"),
          ),
        );
      }
    } else {
      Navigator.pop(context);
    }
  }
}
