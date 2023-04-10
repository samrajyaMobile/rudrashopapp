import 'dart:convert';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColor.mainColor,
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, int index) {
                AddToCartModel cart = cartList[index];
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
                                      "https://drive.google.com/uc?id=${cart.productImage ?? ""}",
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          cart.productName ?? "",
                                          style: AppFonts.regularBlack,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          cart.productModel ?? "",
                                          style: AppFonts.textFieldLabelBlack,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Total : ${cart.total.toString()}",
                                          maxLines: 2,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Min Qty : ${cart.productQty.toString()} pcs",
                                          style: AppFonts.regularBlack,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 5,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                  backgroundColor: MaterialStateProperty.all(AppColor.mainColor),
                  overlayColor: MaterialStateProperty.all(Colors.white10),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Proceed to check-out",
                    style: AppFonts.textFieldWhite,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void getData() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        String? stringData;
        SharedPreferences preferences = await SharedPreferences.getInstance();
        setState(
          () {
            stringData = preferences.getString(SharedPrefConstant.CART_LIST);
            List<dynamic> jsonData = json.decode(stringData ?? "");
            cartList = List.from(jsonData).map((e) => AddToCartModel.fromJson(e)).toList();
          },
        );
      },
    );
  }
}
