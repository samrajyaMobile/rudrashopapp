// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/http/model/Invoice.dart';
import 'package:rudrashop/http/model/Supplier.dart';
import 'package:rudrashop/http/model/Customer.dart';
import 'package:rudrashop/http/model/add_to_cart_model.dart';
import 'package:rudrashop/pages/order_confirm.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_dialog.dart';
import 'package:rudrashop/utils/app_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<AddressModel>(context, listen: false).getPrefData();
      Provider.of<AddressModel>(context, listen: false).setListNull();
      Provider.of<AddressModel>(context, listen: false).getAddress();
      Provider.of<AddressModel>(context, listen: false).getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AddressModel>(builder: (context, am, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            backgroundColor: AppColor.mainColor,
            title: const Text("Shipping Address"),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateProperty.all(AppColor.mainColor),
                        value: 1,
                        groupValue: am.customAddress,
                        onChanged: (val) {
                          setState(() {
                            am.customAddress = val!;
                          });
                        },
                      ),
                      Text(
                        "Default Address",
                        style: AppFonts.semiBoldBlack,
                      ),
                    ],
                  ),
                  am.customAddress == 1
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(am.address ?? ""),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : Container(),
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateProperty.all(AppColor.mainColor),
                        value: 2,
                        groupValue: am.customAddress,
                        onChanged: (val) {
                          setState(() {
                            am.customAddress = val!;
                          });
                        },
                      ),
                      Text(
                        "Custom Address",
                        style: AppFonts.semiBoldBlack,
                      ),
                    ],
                  ),
                  am.customAddress == 2
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: TextFormField(
                                  controller: am._address1,
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
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: TextFormField(
                                  controller: am._address2,
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
                                    decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: TextFormField(
                                        controller: am._state,
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
                                    decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: TextFormField(
                                        controller: am._city,
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
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: TextFormField(
                                  controller: am._pin,
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
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: TextFormField(
                                  controller: am._moNumber,
                                  style: AppFonts.textFieldBlack,
                                  decoration: InputDecoration(
                                    label: const Text("Mobile Number"),
                                    labelStyle: AppFonts.textFieldLabelGary,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          backgroundColor: MaterialStateProperty.all(AppColor.mainColor),
                          overlayColor: MaterialStateProperty.all(Colors.white10),
                        ),
                        onPressed: () async {
                          if (am.customAddress == 1) {
                            am.makeDefaultOrder(context);
                          } else {
                            am.makeCustomOrder(context);
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Place the order",
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
      }),
    );
  }
}

class AddressModel extends ChangeNotifier {
  String? uId;
  String? email;
  String? number;
  String? address;
  String? firstName;
  String? secondName;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? pin;
  String? state;
  List<AddToCartModel> cartList = [];
  List<LineItemModel> lineItem = [];
  int customAddress = 1;

  final TextEditingController _address1 = TextEditingController();
  final TextEditingController _address2 = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _pin = TextEditingController();
  final TextEditingController _moNumber = TextEditingController();

  getAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    address = "${preferences.getString(SharedPrefConstant.U_ADDRESS1)},"
        "\n${preferences.getString(SharedPrefConstant.U_ADDRESS2)},"
        "\n${preferences.getString(SharedPrefConstant.U_CITY)}"
        "- ${preferences.getString(SharedPrefConstant.U_PIN)},"
        "\n${preferences.getString(SharedPrefConstant.U_STATE)}."
        "\nContact Number : ${preferences.getString(SharedPrefConstant.U_MO_NUMBER)}";
    notifyListeners();
  }

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? strData = (preferences.getString(SharedPrefConstant.CART_LIST) ?? "");

    if (strData != "") {
      var jsonData = json.decode(strData);
      var list = List<dynamic>.from(jsonData);
      cartList = list.map((e) => AddToCartModel.fromJson(e)).toList();
      notifyListeners();
    }

    for (var i = 0; i < cartList.length; ++i) {
      var request = LineItemModel(productId: cartList[i].id, quantity: cartList[i].productQty);
      lineItem.add(request);
      notifyListeners();
    }
  }

  getPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    uId = preferences.getString(SharedPrefConstant.U_ID);
    email = preferences.getString(SharedPrefConstant.U_EMAIL);
    number = preferences.getString(SharedPrefConstant.U_MO_NUMBER);
    firstName = preferences.getString(SharedPrefConstant.U_FIRST_NAME);
    secondName = preferences.getString(SharedPrefConstant.U_LAST_NAME);
    addressLine1 = preferences.getString(SharedPrefConstant.U_ADDRESS1);
    addressLine2 = preferences.getString(SharedPrefConstant.U_ADDRESS2);
    city = preferences.getString(SharedPrefConstant.U_CITY);
    pin = preferences.getString(SharedPrefConstant.U_PIN);
    state = preferences.getString(SharedPrefConstant.U_STATE);
    notifyListeners();
  }

  setListNull() {
    lineItem = [];
    cartList = [];
    notifyListeners();
  }

  makeDefaultOrder(BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: true);
    var defaultOrder = {
      "payment_method": "cod",
      "payment_method_title": "Cash on Delivery",
      "status": "processing",
      "set_paid": true,
      "customer_id": uId,
      "billing": {
        "first_name": firstName,
        "last_name": secondName,
        "address_1": addressLine1,
        "address_2": addressLine2,
        "city": city,
        "state": state,
        "postcode": pin,
        "country": "IN",
        "email": email,
        "phone": number
      },
      "line_items": lineItem
    };

    String url =
        "https://samrajya.co.in/index.php/wp-json/wc/v3/orders?consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637";
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(defaultOrder),
    );
    if (response.statusCode == 201) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderConfirm()));
    } else {}
  }

  makeCustomOrder(BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: false);
    var add1 = _address1.text;
    var add2 = _address2.text;
    var cCity = _city.text;
    var cState = _state.text;
    var cPin = _pin.text;
    var cPhone = _moNumber.text;

    var customOrder = {
      "payment_method": "cod",
      "payment_method_title": "Cash on Delivery",
      "status": "processing",
      "set_paid": true,
      "customer_id": uId,
      "billing": {
        "first_name": firstName,
        "last_name": secondName,
        "address_1": add1,
        "address_2": add2,
        "city": cCity,
        "state": cState,
        "postcode": cPin,
        "country": "IN",
        "email": email,
        "phone": cPhone
      },
      "line_items": lineItem
    };
    String url =
        "https://samrajya.co.in/index.php/wp-json/wc/v3/orders?consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637";
    var response = await http.post(
      Uri.parse(url),
      body: json.encode(customOrder),
    );
    if (response.statusCode == 201) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderConfirm()));
    } else {}
  }
}

class LineItemModel {
  int? productId;
  int? quantity;

  LineItemModel({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
      };
}
