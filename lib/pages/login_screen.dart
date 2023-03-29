import 'package:flutter/material.dart';
import 'package:rudrashop/pages/signup.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_fonts.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                          labelStyle: AppFonts.textFieldLabel,
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
                          labelStyle: AppFonts.textFieldLabel,
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
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Don't have an account?",style: AppFonts.textFieldBlack,),
                        Image.asset("assets/images/arrow_right.png",scale: 2,)
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
        ));
  }
}
