import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/pages/orders_list.dart';
import 'package:rudrashop/pages/profile.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBiz extends StatefulWidget {
  const MyBiz({Key? key}) : super(key: key);

  @override
  State<MyBiz> createState() => _MyBizState();
}

class _MyBizState extends State<MyBiz> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MyBizModel>(context, listen: false).getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MyBizModel>(builder: (context, mybiz, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xffce1c36),
                  Color(0xffFD5554),
                  Color(0xffC22F37),
                  Color(0xff7D0012),
                  Color(0xffce1c36),
                  Color(0xffFD5554),
                  Color(0xffC22F37),
                ])
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "R",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${mybiz.businessName}",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "${mybiz.firstName}",
                              style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.circle,
                                color: Colors.white,
                                size: 5,
                              ),
                            ),
                            Text(
                              "${mybiz.moNumber}",
                              style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Manage Business",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OrderList(),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[200]),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 30,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Orders",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[700],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[200]),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Icon(
                                  Icons.support,
                                  size: 30,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Support",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[700],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Profile(),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[200]),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Icon(
                                    Icons.person_outlined,
                                    size: 30,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Account",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[700],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class MyBizModel extends ChangeNotifier {
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
  }
}
