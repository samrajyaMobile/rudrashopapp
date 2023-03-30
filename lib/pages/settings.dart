import 'package:flutter/material.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  "My Profile",
                  style: AppFonts.semiBoldBlack,
                )),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.black1,
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Privacy & Policy",
                  style: AppFonts.semiBoldBlack,
                )),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.black1,
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Logout",
                  style: AppFonts.semiBoldMain,
                )),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
