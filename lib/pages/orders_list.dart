// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:rudrashop/utils/app_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constant.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<OrdersModal>(context, listen: false).getPrefData();
      await Provider.of<OrdersModal>(context, listen: false).getOrdersList(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<OrdersModal>(builder: (context, om, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Past Orders"),
            backgroundColor: AppColor.mainColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: om.orderList.length,
                    itemBuilder: (context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.7,
                            decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey[200]!), color: Colors.grey[50]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Order Id : ",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            om.orderList[index]["id"].toString(),
                                            style: const TextStyle(fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Order Status : ",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            om.orderList[index]["status"],
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: om.orderList[index]["status"] == "cancelled" ? Colors.red : Colors.green,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Order Date : ",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            om.orderList[index]["date_created"].toString().split('T')[0],
                                            style: const TextStyle(fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Order Total : ",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            om.orderList[index]["total"],
                                            style: const TextStyle(fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class OrdersModal extends ChangeNotifier {
  List<dynamic> orderList = [];
  String? uId;
  String? url;

  getOrdersList(BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: false);
    url =
        "https://samrajya.co.in/index.php/wp-json/wc/v3/orders?customer=$uId&page=1&consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637&per_page=100";
    notifyListeners();
    var response = await http.get(Uri.parse(url!));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      orderList = List<dynamic>.from(jsonData);
      notifyListeners();
    } else {
      Navigator.pop(context);
    }
  }

  getPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    uId = preferences.getString(SharedPrefConstant.U_ID);
    notifyListeners();
  }
}
