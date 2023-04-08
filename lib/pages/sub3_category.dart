// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rudrashop/http/model/main_products_response.dart';
import 'package:rudrashop/http/model/sub3_category_response.dart';
import 'package:rudrashop/pages/main_products_list.dart';
import 'package:rudrashop/pages/products_details.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_fonts.dart';

import '../utils/app_dialog.dart';

// ignore: must_be_immutable
class Sub3Category extends StatefulWidget {
  String? subCategoryName;
  String? subCategoryId;

  Sub3Category(
      {super.key, required this.subCategoryName, required this.subCategoryId});

  @override
  State<Sub3Category> createState() => _Sub3CategoryState();
}

class _Sub3CategoryState extends State<Sub3Category> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<Sub3CategoryModel>(context, listen: false)
          .getSub3Category(widget.subCategoryId ?? "", context);
      await Provider.of<Sub3CategoryModel>(context, listen: false)
          .getProductsList(context, widget.subCategoryId ?? "");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<Sub3CategoryModel>(builder: (context, sub3Category, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.mainColor,
            title: Text(widget.subCategoryName ?? ""),
          ),
          body: WillPopScope(
            onWillPop: () async {
              sub3Category.makeListNull();
              return true;
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Select type of ${widget.subCategoryName} : ",
                      style: AppFonts.semiBoldBlack,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 2 / 1),
                      shrinkWrap: true,
                      itemCount: sub3Category.sub3CategoryList.length,
                      itemBuilder: (context, int index) {
                        Sub3CategoryData subCate =
                            sub3Category.sub3CategoryList[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainProductsList(
                                  sub3CategoryId: subCate.sub3CategoryId,
                                  sub3CategoryName: subCate.sub3CategoryName,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColor.black7),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.network(
                                        "https://drive.google.com/uc?id=${subCate.sub3CategoryImage ?? ""}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          subCate.sub3CategoryName ?? "",
                                          style: AppFonts.textFieldLabelBlack,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "All Items :",
                        style: AppFonts.semiBoldBlack,
                      ),
                    ),
                    Container(
                      color: AppColor.white,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 2 / 3),
                        itemCount: sub3Category.productsList.length,
                        itemBuilder: (context, int index) {
                          MainProductData? products =
                              sub3Category.productsList[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductsDetails(
                                            pId: products.pId,
                                            categoryId: products.categoryId,
                                            categoryName: products.categoryName,
                                            subCategoryId: products.subCategoryId,
                                            subCategoryName: products.subCategoryName,
                                            sub3CategoryId: products.sub3CategoryId,
                                            sub3CategoryName: products.sub3CategoryName,
                                            productName: products.productName,
                                            productSp: products.productSp,
                                            productMrp: products.productMrp,
                                            pGst: products.pGst,
                                            discount: products.discount,
                                            productMoq: products.productMoq,
                                            productsDic: products.productsDescr,
                                            image1: products.image1,
                                            image2: products.image2,
                                            image3: products.image3,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColor.black7),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Image.network(
                                                  "https://drive.google.com/uc?id=${products.image1 ?? ""}",
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColor.mainColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "${products.discount}% Off",
                                                      style: AppFonts
                                                          .semiBoldWhite12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        products.sub3CategoryName ?? "",
                                        style: AppFonts.regularBlack,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        products.productName ?? "",
                                        style: AppFonts.semiBoldBlack,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "₹${products.productMrp ?? " "}",
                                            style: AppFonts.mainPrice,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "₹${products.productSp ?? " "}",
                                            style: AppFonts.mediumMainRed,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
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
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class Sub3CategoryModel extends ChangeNotifier {
  List<Sub3CategoryData> sub3CategoryList = [];
  List<MainProductData> productsList = [];

  getSub3Category(String subCategoryId, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => const LoadingDialog(),
        barrierDismissible: false);
    var url =
        "${AppConstant.GET_SUB3_CATEGORIES}${QueryParamsConstant.SUB_CATEGORY_ID}=$subCategoryId&sub3CategoryId=0";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      if (jsonData["status"] ?? false) {
        var data = Sub3CategoryResponse.fromJson(jsonData);
        if (data.status ?? false) {
          sub3CategoryList = data.sub3Category ?? [];
          notifyListeners();
        } else {
          makeListNull();
        }
      } else {
        makeListNull();
      }
    } else {
      Navigator.pop(context);
      makeListNull();
    }
  }

  getProductsList(BuildContext context, String subCategory) async {
    showDialog(
        context: context,
        builder: (context) => const LoadingDialog(),
        barrierDismissible: false);

    var url =
        "${AppConstant.GET_MAIN_PRODUCTS}${QueryParamsConstant.SUB_CATEGORY_ID}=$subCategory&sub3CategoryId=0";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      if (jsonData["status"] ?? false) {
        var finalData = MainProductsResponse.fromJson(jsonData);
        productsList = finalData.mainProducts ?? [];
        notifyListeners();
      } else {
        makeListNull();
      }
    } else {
      Navigator.pop(context);
      makeListNull();
    }
  }

  makeListNull() {
    sub3CategoryList = [];
    productsList = [];
    notifyListeners();
  }
}
