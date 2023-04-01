import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rudrashop/http/model/login_response.dart';
import 'package:rudrashop/pages/signup.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
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
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100))),
                          backgroundColor:
                              MaterialStateProperty.all(AppColor.mainColor),
                          overlayColor:
                              MaterialStateProperty.all(Colors.white10),
                        ),
                        onPressed: () {
                          login.login();
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

  login() async {
    String u_email = _email.text.toLowerCase().trim();
    String u_password = _email.text.trim();

    Map<dynamic, String> loginBody = {
      "u_email": u_email,
      "u_password": u_password,
    };

    Map<String, String> headers = {'Content-Type': 'application/json'};

    String stringBody = jsonEncode(loginBody);

    var response = await http.post(Uri.parse(AppConstant.POST_LOGIN),
        headers: headers, body: stringBody);

    print(AppConstant.POST_LOGIN);

    String? redirectUrl = response.headers['location'];
    print('Redirect URL: $redirectUrl');

    print(response.body);

    var response2 =
        await http.post(Uri.parse(redirectUrl ?? ""), body: stringBody);

    print(response2.body);

    if (response2.statusCode == 200) {
      var jsonData = json.decode(response2.body);

      if (jsonData["status"] ?? false) {
        var data = LoginResponse.fromJson(jsonData);

        if (data.status ?? false) {
          print("Nikesh");
        } else {
          print("Nikesh1");
        }
      } else {
        print("Nik 2+3");
      }
    }
  }
}
