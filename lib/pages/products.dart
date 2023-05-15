// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rudrashop/http/model/variant_products_response.dart';
import 'package:rudrashop/pages/products_details.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_dialog.dart';
import 'package:rudrashop/utils/app_fonts.dart';
import 'package:http/http.dart' as http;

class Products extends StatefulWidget {
  String? categoryId;
  String? tag;

  Products(
      {super.key,
      required this.categoryId,
      required this.tag,
      required this.categoryName});

  String? categoryName;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<dynamic> list = [];
  int page = 1;
  String? url;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.tag == "featured") {
        setState(() {
          url =
              "https://samrajya.co.in/index.php/wp-json/wc/v3/products?consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637&featured=true&$page&per_page=100";
        });
      }else if(widget.tag == "newArrivals"){
        setState(() {
          url =
          "https://samrajya.co.in/index.php/wp-json/wc/v3/products?custom_fields=New Arrival:true&consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637&per_page=100&$page";
        });
      }else if(widget.tag == "mobileAccessories"){
        setState(() {
          url =
          "https://samrajya.co.in/index.php/wp-json/wc/v3/products?consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637&per_page=100&page=1&category=${widget.categoryId}";
        });
      }else{
        setState(() {
          url =
          "https://samrajya.co.in/index.php/wp-json/wc/v3/products?consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637&per_page=100&page=1&category=${widget.categoryId}";
        });
      }

      getProducts(page);
    });

    super.initState();
  }

  getProducts(int nPage) async {
    showDialog(
        context: context,
        builder: (context) => const LoadingDialog(),
        barrierDismissible: false);
    var response = await http.get(Uri.parse(url!));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      setState(() {
        list = List<dynamic>.from(jsonData);
      });
    }
  }

  nextPage() {
    page = page + 1;
    getProducts(page);
  }

  previous() {
    if (page != 0) {
      page = page - 1;
      getProducts(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        title: Text(widget.categoryName ?? ""),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            (list.isNotEmpty)
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 2 / 3),
                    itemCount: list.length,
                    itemBuilder: (context, int index) {
                      //ProductData? products = home.productsList?[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsDetails(
                                pId: list[index]["id"].toString(),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                              border: Border.all(color: AppColor.black5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(list[index]
                                              ["images"].isNotEmpty ?list[index]
                                                  ["images"][0]["src"]: "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg" ))),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        list[index]["categories"].isNotEmpty ? list[index]["categories"][0]["name"] : "",
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        list[index]["name"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      (list[index]["stock_quantity"] != null &&
                                              list[index]["stock_quantity"] !=
                                                  0)
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "₹${list[index]["price"]}",
                                                  style: TextStyle(
                                                      color: AppColor.red,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: AppColor.red),
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text("No More Products in this Category",
                          style: TextStyle(
                              color: AppColor.mainColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 25),
                          textAlign: TextAlign.center),
                    ),
                  ),
            const SizedBox(height: 10),
            (list.isEmpty)
                ? InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.mainColor),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Explore More",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          previous();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: AppColor.mainColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.skip_previous,
                                color: AppColor.mainColor,
                                size: 30,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Page : ${page.toString()}",
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          nextPage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: AppColor.mainColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.skip_next,
                              color: AppColor.mainColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
