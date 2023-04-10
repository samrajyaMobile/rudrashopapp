// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_fonts.dart';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: LottieBuilder.asset(
            "assets/images/loading.json",
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}

class ErrorDialog extends StatefulWidget {
  String? errorTitle;
  String? errorMsg;

  ErrorDialog({super.key, required this.errorTitle, required this.errorMsg});

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 75,
              height: 75,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/warning.png"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.errorTitle ?? "",
              style: AppFonts.subTitle,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.errorMsg ?? "",
              style: AppFonts.semiBoldBlack,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
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
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Try Again",
                      style: AppFonts.textFieldWhite,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
