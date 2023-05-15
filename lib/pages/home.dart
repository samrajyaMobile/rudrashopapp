// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart';
import 'package:rudrashop/pages/all_category.dart';
import 'package:rudrashop/pages/products.dart';
import 'package:rudrashop/pages/products_details.dart';
import 'package:rudrashop/pages/sub_categoty.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:rudrashop/utils/app_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeModel>(context, listen: false).getFeaturesProducts(context);
      Provider.of<HomeModel>(context, listen: false).getNewArrivalsProducts(context);
      Provider.of<HomeModel>(context, listen: false).getAllCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(builder: (context, home, _) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                              gradient: LinearGradient(colors: [
                                Color(0xffce1c36),
                                Color(0xffFD5554),
                                Color(0xffC22F37),
                                Color(0xff7D0012),
                                Color(0xffce1c36),
                                Color(0xffFD5554),
                                Color(0xffC22F37),
                              ]),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Shop by Category",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AllCategory(),
                                ),
                              );
                            },
                            child:  Text(
                              "View All",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[500],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 8,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: home.allCategoryList.length,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SubCategoryScreen(
                                      categoryName:home.allCategoryList[index]["name"],
                                      categoryId: home.allCategoryList[index]["id"].toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey[200]!), color: Colors.grey[50]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Image.network(
                                                home.allCategoryList[index]["image"]["src"] ?? "",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            home._parseHtmlString(
                                              home.allCategoryList[index]["name"],
                                            ),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
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
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                              gradient: LinearGradient(colors: [
                                Color(0xffce1c36),
                                Color(0xffFD5554),
                                Color(0xffC22F37),
                                Color(0xff7D0012),
                                Color(0xffce1c36),
                                Color(0xffFD5554),
                                Color(0xffC22F37),
                              ]),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Featured",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Products(
                                            categoryId: "0",
                                            categoryName: "Featured",
                                            tag: 'featured',
                                          )));
                            },
                            child:  Text(
                              "View All",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[500],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        child: ListView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: home.featuredList.length,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductsDetails(
                                      pId: home.featuredList[index]["id"].toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey[200]!),
                                    color: Colors.grey[50],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Image.network(
                                                home.featuredList[index]["images"][0]["src"] ?? "",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            home.featuredList[index]["categories"][0]["name"],
                                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            home.featuredList[index]["name"],
                                            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          (home.featuredList[index]["stock_quantity"] != null && home.featuredList[index]["stock_quantity"] != 0)
                                              ? Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      "₹${home.featuredList[index]["price"]}",
                                                      style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: AppColor.red),
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(4.0),
                                                    child: Text(
                                                      "Out Of Stock",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                              gradient: LinearGradient(colors: [
                                Color(0xffce1c36),
                                Color(0xffFD5554),
                                Color(0xffC22F37),
                                Color(0xff7D0012),
                                Color(0xffce1c36),
                                Color(0xffFD5554),
                                Color(0xffC22F37),
                              ]),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "New Arrivals",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Products(
                                            categoryId: "0",
                                            categoryName: "New Arrivals",
                                            tag: 'newArrivals',
                                          )));
                            },
                            child:  Text(
                              "View All",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[500],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        child: ListView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: home.newArrivalsList.length,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductsDetails(
                                      pId: home.newArrivalsList[index]["id"].toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2.7,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey[200]!), color: Colors.grey[50]),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Image.network(
                                                home.newArrivalsList[index]["images"].isNotEmpty
                                                    ? home.newArrivalsList[index]["images"][0]["src"]
                                                    : "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            home.newArrivalsList[index]["categories"].isNotEmpty ? home.newArrivalsList[index]["categories"][0]["name"] : "",
                                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            home.newArrivalsList[index]["name"],
                                            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          (home.newArrivalsList[index]["stock_quantity"] != null && home.newArrivalsList[index]["stock_quantity"] != 0)
                                              ? Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      "₹${home.newArrivalsList[index]["price"]}",
                                                      style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                )
                                              : Center(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(4),
                                                      color: Colors.red
                                                    ),
                                                    child: const Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Text(
                                                        "Out Of Stock",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                              gradient: LinearGradient(colors: [
                                Color(0xffce1c36),
                                Color(0xffFD5554),
                                Color(0xffC22F37),
                                Color(0xff7D0012),
                                Color(0xffce1c36),
                                Color(0xffFD5554),
                                Color(0xffC22F37),
                              ]),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Mobile Accessories",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      home.mobileAccessories == 0
                          ? Container()
                          : Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 7 / 3),
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: home.mobileCategoryList.length,
                                    itemBuilder: (context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Products(
                                                        categoryId: home.mobileCategoryList[index]["id"].toString(),
                                                        categoryName: "Mobile Accessories",
                                                        tag: 'mobileAccessories',
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey[200]!), color: Colors.grey[50]),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Image.network(
                                                        home.mobileCategoryList[index]["image"]["src"] ?? "",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      home._parseHtmlString(
                                                        home.mobileCategoryList[index]["name"],
                                                      ),
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.grey,
                                                    size: 12,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class HomeModel extends ChangeNotifier {
  List<dynamic> featuredList = [];
  List<dynamic> allCategoryList = [];
  List<dynamic> mobileCategoryList = [];
  List<dynamic> newArrivalsList = [];
  int mobileAccessories = 0;

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body?.text ?? "").documentElement?.text ?? "";
    return parsedString;
  }

  getMobileAccessories() {
    for (var i = 0; i < allCategoryList.length; ++i) {
      if (allCategoryList[i]["name"] == "Mobile Accessories") {
        mobileAccessories = allCategoryList[i]["id"];
        notifyListeners();
        getMobileCategory(mobileAccessories);
        break;
      }
    }
  }

  getAllCategory() async {
    String url =
        "https://samrajya.co.in/index.php/wp-json/wc/v3/products/categories?orderby=count&order=desc&consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637&parent=0";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      allCategoryList = List<dynamic>.from(jsonData);
      notifyListeners();
      getMobileAccessories();
    }
  }

  getMobileCategory(int id) async {
    String url =
        "https://samrajya.co.in/index.php/wp-json/wc/v3/products/categories?parent=$id&consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      mobileCategoryList = List<dynamic>.from(jsonData);
      notifyListeners();
    }
  }

  getFeaturesProducts(BuildContext context) async {
    String url =
        "https://samrajya.co.in/index.php/wp-json/wc/v3/products?consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637&featured=true";
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: false);
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      featuredList = List<dynamic>.from(jsonData);
      notifyListeners();
    }
  }

  getNewArrivalsProducts(BuildContext context) async {
    String url =
        "https://samrajya.co.in/index.php/wp-json/wc/v3/products?custom_fields=New Arrival:true&consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637&per_page=100&page=1";
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: false);
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      newArrivalsList = List<dynamic>.from(jsonData);
      notifyListeners();
    }
  }
}
