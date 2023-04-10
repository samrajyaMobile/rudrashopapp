import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rudrashop/http/model/Invoice.dart';
import 'package:rudrashop/http/model/Supplier.dart';
import 'package:rudrashop/http/model/Customer.dart';
import 'package:rudrashop/http/model/add_to_cart_model.dart';
import 'package:rudrashop/http/model/pdf_invoicea_api.dart';
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
      await getAddress();
      await getData();
    });
    super.initState();
  }

  getAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      address = preferences.getString(SharedPrefConstant.U_ADDRESS);
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
                      final date = DateTime.now();
                      final duDate = date.add(const Duration(days: 3));
                      Invoice invoice;

                      for (var i = 0; i < cartList.length; ++i) {
                         invoice = Invoice(
                          supplier: const Supplier(
                            name: "Samragya Group",
                          ),
                          customer: const Customer(name: 'Nikesh Sagathiya', address: '5-Rohidashpara Rajkot - 360003'),
                          info: InvoiceInfo(description: "My Description", number: "", date: DateTime.now(), dueDate: duDate),
                          items: [
                            InvoiceItem(productName: ca, date: date, quantity: quantity, gst: gst, unitPrice: unitPrice)
                          ],
                        );
                      }



                      final pdfFile = await PdfInvoiceApi.generate(invoice);

                      PdfApi.openFile(pdfFile);
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
