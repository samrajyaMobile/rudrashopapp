// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/http/model/deal_products_response.dart';
import 'package:rudrashop/pages/products_details.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_dialog.dart';
import 'package:rudrashop/utils/app_fonts.dart';

class DealProducts extends StatefulWidget {
  const DealProducts({Key? key}) : super(key: key);

  @override
  State<DealProducts> createState() => _DealProductsState();
}

class _DealProductsState extends State<DealProducts> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DealProductsModel>(context, listen: false).getDeal(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.mainColor,
          title: const Text("Deal of the Day"),
        ),
        body: Consumer<DealProductsModel>(builder: (context, mainProducts, _) {
          return WillPopScope(
            onWillPop: () async {
              mainProducts.makeListNull();
              return true;
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: mainProducts.productsList.length,
                    itemBuilder: (context, int index) {
                      DealProductData? products = mainProducts.productsList[index];
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
                                productMrp: products.productMrp.toString(),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColor.black7),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Image.network(
                                      "https://drive.google.com/uc?id=${products.image1 ?? ""}",
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
                                        Row(
                                          children: [
                                            Text(
                                              "₹ ${products.productMrp.toString() ?? ""}",
                                              style: AppFonts.mainPrice,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(color: AppColor.mainColor, borderRadius: BorderRadius.circular(25)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${products.discount.toString() ?? ""}% off",
                                                  style: AppFonts.semiBoldWhite,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
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
            ),
          );
        }),
      ),
    );
  }
}

class DealProductsModel extends ChangeNotifier {
  List<DealProductData> productsList = [];

  getDeal(BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: false);
    var response = await http.get(Uri.parse(AppConstant.GET_DEAL_OF_THE_DAY));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      if (jsonData["status"] ?? false) {
        var finalData = DealProductsResponse.fromJson(jsonData);
        productsList = finalData.mainProducts ?? [];
        notifyListeners();
      } else {
        productsList = [];
        notifyListeners();
      }
    } else {
      Navigator.pop(context);
      productsList = [];
      notifyListeners();
    }
  }

  makeListNull() {
    productsList = [];
    notifyListeners();
  }
}
