// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_dialog.dart';
import 'package:rudrashop/utils/app_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    Provider.of<ProfileModel>(context, listen: false).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ProfileModel>(builder: (context, profile, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            backgroundColor: AppColor.mainColor,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              controller: profile._firstName,
                              style: AppFonts.textFieldBlack,
                              decoration: InputDecoration(
                                label: const Text("First Name"),
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
                              style: AppFonts.textFieldBlack,
                              controller: profile._lastName,
                              decoration: InputDecoration(
                                label: const Text("Last Name"),
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
                        controller: profile._businessName,
                        style: AppFonts.textFieldBlack,
                        decoration: InputDecoration(
                          label: const Text("Business Name"),
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
                        controller: profile._moNumber,
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
                        style: AppFonts.textFieldBlack,
                        controller: profile._email,
                        readOnly: true,
                        decoration: InputDecoration(
                          label: const Text("E-mail"),
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
                        controller: profile._gst,
                        style: AppFonts.textFieldBlack,
                        decoration: InputDecoration(
                          label: const Text("Gst No."),
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
                        controller: profile._addressLine1,
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
                        controller: profile._addressLine2,
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
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        controller: profile._pincode,
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
                    height: 20,
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
                              controller: profile._state,
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
                              controller: profile._city,
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        backgroundColor: MaterialStateProperty.all(AppColor.mainColor),
                        overlayColor: MaterialStateProperty.all(Colors.white10),
                      ),
                      onPressed: () {
                        profile.upDate(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Update",
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

class ProfileModel extends ChangeNotifier {
  String? url;

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _businessName = TextEditingController();
  final TextEditingController _moNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _gst = TextEditingController();
  final TextEditingController _addressLine1 = TextEditingController();
  final TextEditingController _addressLine2 = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _pincode = TextEditingController();

  String? uId;
  String? firstName;
  String? lastName;
  String? businessName;
  String? moNumber;
  String? email;
  String? gst;
  String? addressLine1;
  String? addressLine2;
  String? state;
  String? city;
  String? pincode;

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    uId = preferences.getString(SharedPrefConstant.U_ID);
    firstName = preferences.getString(SharedPrefConstant.U_FIRST_NAME);
    lastName = preferences.getString(SharedPrefConstant.U_LAST_NAME);
    businessName = preferences.getString(SharedPrefConstant.U_BUSINESS_NAME);
    moNumber = preferences.getString(SharedPrefConstant.U_MO_NUMBER);
    email = preferences.getString(SharedPrefConstant.U_EMAIL);
    gst = preferences.getString(SharedPrefConstant.U_GST);
    addressLine1 = preferences.getString(SharedPrefConstant.U_ADDRESS1);
    addressLine2 = preferences.getString(SharedPrefConstant.U_ADDRESS2);
    state = preferences.getString(SharedPrefConstant.U_STATE);
    city = preferences.getString(SharedPrefConstant.U_CITY);
    pincode = preferences.getString(SharedPrefConstant.U_PIN);
    notifyListeners();

    _firstName.text = firstName ?? "";
    _lastName.text = lastName ?? "";
    _businessName.text = businessName ?? "";
    _moNumber.text = moNumber ?? "";
    _email.text = email ?? "";
    _gst.text = gst ?? "";
    _addressLine1.text = addressLine1 ?? "";
    _addressLine2.text = addressLine2 ?? "";
    _state.text = state ?? "";
    _city.text = city ?? "";
    _pincode.text = pincode ?? "";
    notifyListeners();
  }

  upDate(BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: false);
    url =
        "https://samrajya.co.in/index.php/wp-json/wc/v3/customers/$uId?consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637";
    notifyListeners();

    Map<String, dynamic> map = {
      "user_id": 2051,
      "first_name": _firstName.text,
      "last_name": _lastName.text,
      "email": _email.text,
      "billing": {
        "company": _businessName.text,
        "first_name": _firstName.text,
        "last_name": _lastName.text,
        "address_1": _addressLine1.text,
        "address_2": _addressLine2.text,
        "city": _city.text,
        "state": _state.text,
        "postcode": _pincode.text,
        "country": "IND",
        "phone": _moNumber.text
      }
    };

    var response = await http.post(Uri.parse(url!), headers: {"Content-Type": "application/json"}, body: json.encode(map));

    print(response.body);

    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(SharedPrefConstant.U_FIRST_NAME, jsonData["first_name"].toString() ?? "");
      sharedPreferences.setString(SharedPrefConstant.U_LAST_NAME, jsonData["last_name"].toString() ?? "");
      sharedPreferences.setString(SharedPrefConstant.U_MO_NUMBER, jsonData["billing"]["phone"].toString() ?? "");
      sharedPreferences.setString(SharedPrefConstant.U_ADDRESS1, jsonData["billing"]["address_1"].toString() ?? "");
      sharedPreferences.setString(SharedPrefConstant.U_ADDRESS2, jsonData["billing"]["address_2"].toString() ?? "");
      sharedPreferences.setString(SharedPrefConstant.U_CITY, jsonData["billing"]["city"].toString() ?? "");
      sharedPreferences.setString(SharedPrefConstant.U_PIN, jsonData["billing"]["postcode"].toString() ?? "");
      sharedPreferences.setString(SharedPrefConstant.U_STATE, jsonData["billing"]["state"].toString() ?? "");
      sharedPreferences.setString(SharedPrefConstant.U_BUSINESS_NAME, jsonData["billing"]["company"].toString() ?? "");

      if (jsonData["meta_data"].isNotEmpty) {
        for (var i = 0; i < jsonData["meta_data"].length; ++i) {
          if (jsonData["meta_data"][i]["key"] == "billing_gst") {
            sharedPreferences.setString(SharedPrefConstant.U_GST, jsonData["meta_data"][i]["value"].toString());
          }
        }
      }
      getData();
    }
  }
}
