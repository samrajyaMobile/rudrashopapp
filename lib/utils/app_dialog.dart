import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rudrashop/utils/app_colors.dart';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: LottieBuilder.asset("assets/images/loading.json",height: 200,width: 200,),
      ),
    );
  }
}

