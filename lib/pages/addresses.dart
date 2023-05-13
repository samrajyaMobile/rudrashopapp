import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rudrashop/http/model/Invoice.dart';
import 'package:rudrashop/http/model/Supplier.dart';
import 'package:rudrashop/http/model/Customer.dart';
import 'package:rudrashop/http/model/add_to_cart_model.dart';
import 'package:rudrashop/pages/orders_map.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String? address;
  List<AddToCartModel> cartList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await createOrderMap();
      await getAddress();
      await getData();
    });
    super.initState();
  }

  getAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      address = preferences.getString(SharedPrefConstant.U_ADDRESS1);
    });
  }

  getData() async {
    String? stringData;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(
      () {
        stringData = preferences.getString(SharedPrefConstant.CART_LIST);
        List<dynamic> jsonData = json.decode(stringData ?? "");
        cartList = List.from(jsonData).map((e) => AddToCartModel.fromJson(e)).toList();
      },
    );
  }

  createOrderMap() {
    List<LineItems> lineItem = [];
    List<ShippingLines> shippingLines = [];

    LineItems item = LineItems(product_id: "16405", quantity: "2");

    setState(() {
      lineItem.add(item);
    });

    ShippingLines shippingLinesRequest = ShippingLines(method_id: "free_shipping", method_title: "Free Shipping", total: "1000.00");

    setState(() {
      shippingLines.add(shippingLinesRequest);
    });

    Billing billing = Billing(
        first_name: "Nikesh",
        last_name: "Sagathiya",
        address_1: "123 Main Street",
        address_2: "123 Main Street",
        city: "San Francisco",
        state: "CA",
        postcode: "94103",
        country: "US",
        email: 'john.doe@example.com',
        phone: "(555) 555-5555");

    Shipping shipping = Shipping(
        first_name: "Nikesh",
        last_name: "Sagathiya",
        address_1: "123 Main Street",
        address_2: "123 Main Street",
        city: "San Francisco",
        state: "CA",
        postcode: "94103",
        country: "US");

    OrdersMap ordersMap = OrdersMap(
        status: "processing",
        payment_method: "cod",
        payment_method_title: "Cash on Delivery",
        set_paid: false,
        billing: billing,
        shipping: shipping,
        line_items: lineItem,
        shipping_lines: shippingLines);

    print(ordersMap.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: AppColor.mainColor,
          title: const Text("Confirm Address"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Address :",
                style: AppFonts.semiBoldBlack,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(address ?? ""),
                ),
              ),
              const Spacer(),
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
                    onPressed: () async {
                      createOrderMap();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Place the order",
                        style: AppFonts.textFieldWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
