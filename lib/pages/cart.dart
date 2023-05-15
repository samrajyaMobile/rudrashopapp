import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rudrashop/http/model/add_to_cart_model.dart';
import 'package:rudrashop/pages/addresses.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<AddToCartModel> cartList = [];
  double? grandTotal;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });

    super.initState();
  }

  setCartData(List<AddToCartModel> list) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String strData = json.encode(list);
    preferences.setString(SharedPrefConstant.CART_LIST, strData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context,true);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            backgroundColor: AppColor.mainColor,
            title: const Text("My Cart"),
          ),
          body: Column(
            children: [
              Expanded(
                child: cartList.isNotEmpty
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cartList.length,
                        itemBuilder: (context, int index) {
                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColor.black7),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 80,
                                              height: 80,
                                              child: Image.network(
                                                cartList[index].image ?? "",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    cartList[index].pCategory ?? "Common Category",
                                                    style: AppFonts.regularBlack,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    cartList[index].name ?? "",
                                                    style: AppFonts.textFieldLabelBlack,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Total Qty. : ${cartList[index].productQty}",
                                                    style: const TextStyle(fontWeight: FontWeight.w700),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Total : ${cartList[index].productQty! * double.parse(cartList[index].price.toString()).round()}",
                                                    maxLines: 2,
                                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            cartList.removeAt(index);
                                          });
                                          setCartData(cartList);
                                        },
                                        icon: const Icon(Icons.delete),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset("assets/images/nodata.json"),
                          const Text(
                            "Your Cart is Empty !",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
              ),
              cartList.isNotEmpty
                  ? Column(
                      children: [
                        const Divider(
                          color: Colors.black,
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Grand Total : ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    "$grandTotal",
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.red),
                                  ),
                                ],
                              )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                      backgroundColor: MaterialStateProperty.all(AppColor.mainColor),
                                      overlayColor: MaterialStateProperty.all(Colors.white10),
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressScreen()));
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        "Proceed to check-out",
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void getData() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? strData = (preferences.getString(SharedPrefConstant.CART_LIST) ?? "");

        if (strData != "") {
          var jsonData = json.decode(strData);
          var list = List<dynamic>.from(jsonData);
          setState(() {
            cartList = list.map((e) => AddToCartModel.fromJson(e)).toList();
          });

          for (var i = 0; i < cartList.length; ++i) {
            double sabTotal = cartList[i].productQty! * double.parse(cartList[i].price.toString());

            grandTotal = (grandTotal ?? 0) + sabTotal.round();
          }
        }
      },
    );
  }
}
