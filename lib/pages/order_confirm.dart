import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rudrashop/pages/dashboard.dart';
import 'package:rudrashop/utils/app_colors.dart';

class OrderConfirm extends StatefulWidget {
  const OrderConfirm({Key? key}) : super(key: key);

  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              LottieBuilder.asset(
                "assets/images/order.json",
                repeat: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Thank you for ",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  Text(
                    "Shopping",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: AppColor.mainColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("You will get your order soon!"),
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      backgroundColor: MaterialStateProperty.all(AppColor.mainColor),
                      overlayColor: MaterialStateProperty.all(Colors.white10),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const Dashboard()), (route) => false);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Find New Products",
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
