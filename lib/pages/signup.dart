import 'package:flutter/material.dart';
import 'package:rudrashop/pages/dashboard.dart';
import 'package:rudrashop/pages/login_screen.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                child: Text("Sign Up", style: AppFonts.title),
              ),
              Container(
                decoration: BoxDecoration(color: AppColor.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextFormField(
                    style: AppFonts.textFieldBlack,
                    decoration: InputDecoration(
                      label: const Text("Name"),
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
                      label: const Text("Surname"),
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
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(color: AppColor.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextFormField(
                    style: AppFonts.textFieldBlack,
                    decoration: InputDecoration(
                      label: const Text("Confirm Password"),
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
                      label: const Text("Full Address"),
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
                      label: const Text("City"),
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
                      label: const Text("Pincode"),
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
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Already have an account?",style: AppFonts.textFieldBlack,),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Dashboard()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "SIGN UP",
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
