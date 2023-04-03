// ignore_for_file: must_be_immutable, use_build_context_synchronously
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rudrashop/http/model/main_products_response.dart';
import 'package:rudrashop/pages/products_details.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:rudrashop/utils/app_fonts.dart';

class MainProductsList extends StatefulWidget {
  String? sub3CategoryId;
  String? sub3CategoryName;

  MainProductsList({super.key, required this.sub3CategoryId, required this.sub3CategoryName});

  @override
  State<MainProductsList> createState() => _MainProductsListState();
}

class _MainProductsListState extends State<MainProductsList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MainProductsListModel>(context, listen: false).getCategories(context, widget.sub3CategoryId ?? "");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        title: Text(widget.sub3CategoryName ?? ""),
      ),
      body: Consumer<MainProductsListModel>(builder: (context, mainProducts, _) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: mainProducts.productsList.length,
                itemBuilder: (context, int index) {
                  MainProductData? products = mainProducts.productsList[index];
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
                                    productSp: products.productSp.toString(),
                                    pGst: products.pGst.toString(),
                                    discount: products.discount.toString(),
                                    productMoq: products.productMoq.toString(),
                                    productsDic: products.productsDescr.toString(),
                                    image1: products.image1.toString(),
                                    image2: products.image2.toString(),
                                    image3: products.image3.toString(),
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColor.mainColor)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    "https://drive.google.com/uc?id=${products.image1 ?? ""}",
                                    scale: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        decoration: BoxDecoration(color: AppColor.mainColor, borderRadius: BorderRadius.circular(25)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${products.discount.toString() ?? ""}% off",
                                            style: AppFonts.semiBoldWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
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
                                      style: AppFonts.textFieldLabelBlack,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "₹ ${products.productMrp.toString() ?? ""}",
                                      style: AppFonts.mainPrice,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "₹ ${products.productSp.toString() ?? ""} per pc",
                                      style: AppFonts.semiBoldBlack,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Min Qty : ${products.productMoq.toString() ?? ""} pcs",
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
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
      }),
    ));
  }
}

class MainProductsListModel extends ChangeNotifier {
  List<MainProductData> productsList = [];

  getCategories(BuildContext context, String sub3Category) async {
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: false);

    var url = "${AppConstant.GET_MAIN_PRODUCTS}${QueryParamsConstant.SUB_3_CATEGORY_ID}=$sub3Category";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      if (jsonData["status"] ?? false) {
        var finalData = MainProductsResponse.fromJson(jsonData);
        productsList = finalData.mainProducts ?? [];
        notifyListeners();
      }
    } else {
      Navigator.pop(context);
    }
  }
}
