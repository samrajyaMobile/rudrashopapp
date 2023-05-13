import 'package:flutter/material.dart';
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
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text("Sign Up", style: AppFonts.title),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: AppColor.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          style: AppFonts.textFieldBlack,
                          decoration: InputDecoration(
                            label: const Text("Display Name"),
                            labelStyle: AppFonts.textFieldLabelGary,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: AppColor.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          style: AppFonts.textFieldBlack,
                          decoration: InputDecoration(
                            label: const Text("Business Name"),
                            labelStyle: AppFonts.textFieldLabelGary,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                      label: const Text("Phone Number"),
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
                      label: const Text("Address Line 1"),
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
                      label: const Text("Address Line 2"),
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: AppColor.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          style: AppFonts.textFieldBlack,
                          decoration: InputDecoration(
                            label: const Text("State"),
                            labelStyle: AppFonts.textFieldLabelGary,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
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
                  ),
                ],
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
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Already have an account?",
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
