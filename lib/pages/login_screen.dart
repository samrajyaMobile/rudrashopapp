// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rudrashop/http/model/login_response.dart';
import 'package:rudrashop/pages/dashboard.dart';
import 'package:rudrashop/pages/signup.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<LoginModel>(builder: (context, login, _) {
        return Scaffold(
          backgroundColor: AppColor.mainBackground,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text("Login", style: AppFonts.title),
                  ),
                  Container(
                    decoration: BoxDecoration(color: AppColor.white),
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
                    decoration: BoxDecoration(color: AppColor.white),
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
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: AppFonts.textFieldBlack,
                        ),
                        Image.asset(
                          "assets/images/arrow_right.png",
                          scale: 2,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                          backgroundColor: MaterialStateProperty.all(AppColor.mainColor),
                          overlayColor: MaterialStateProperty.all(Colors.white10),
                        ),
                        onPressed: () {
                          login.validator(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "LOGIN",
                            style: AppFonts.textFieldWhite,
                          ),
                        )),
                  ),
                ],
              ),
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
    String url = AppConstant.GET_LOGIN;

    var response = await http.get(Uri.parse("$url&u_email=$uEmail&u_password=$uPassword"));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);

      var data = LoginResponse.fromJson(jsonData);

      if (data.status ?? false) {

        sharedPreferences.setBool(SharedPrefConstant.U_LOGIN, true);
        sharedPreferences.setString(SharedPrefConstant.U_EMAIL, data.user?.first.uEmail ?? "");
        sharedPreferences.setString(SharedPrefConstant.U_NAME, data.user?.first.uName ?? "");
        sharedPreferences.setString(SharedPrefConstant.U_SURNAME, data.user?.first.uSurname ?? "");
        sharedPreferences.setString(SharedPrefConstant.U_MO_NUMBER, data.user?.first.uMoNumber.toString() ?? "");
        sharedPreferences.setString(SharedPrefConstant.U_BUSINESS_NAME, data.user?.first.uBusinessName ?? "");
        sharedPreferences.setString(SharedPrefConstant.U_ADDRESS, data.user?.first.uAddress ?? "");
        sharedPreferences.setString(SharedPrefConstant.U_CITY, data.user?.first.uCity ?? "");
        sharedPreferences.setString(SharedPrefConstant.U_PIN, data.user?.first.uPincode.toString() ?? "");

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
      } else {
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(
            errorTitle: 'Login Error',
            errorMsg: data.message,
          ),
        );
      }
    } else {
      Navigator.pop(context);
    }
  }
}
