import 'dart:convert';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:rudrashop/http/model/login_response.dart';
import 'package:rudrashop/pages/signup.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:googleapis/drive/v3.dart' ;
import 'package:googleapis_auth/auth_io.dart';
import 'dart:io';
import 'dart:typed_data';

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
                        style: AppFonts.textFieldBlack,
                        decoration: InputDecoration(
                          label: Text("E-mail"),
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
                        style: AppFonts.textFieldBlack,
                        decoration: InputDecoration(
                          label: Text("Password"),
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupScreen()));
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
                        onPressed: () {},
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


  login() async {
    String uEmail = _email.text.toLowerCase().trim();
    String uPassword = _password.text.trim();

    var response = await http.get(Uri.parse(
        "https://script.google.com/macros/s/AKfycby1cI7i25CsVF35-lj2K0-wQiKc5K9JHJ9S5oLdSdawa_XsnXeDxJYILP8DIkQgjtwO/exec?action=login&u_email=$uEmail&u_password=$uPassword"));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData["status"] ?? false) {
        var data = LoginResponse.fromJson(jsonData);
        if (data.status ?? false) {}
      }
    } else {}
  }
}
