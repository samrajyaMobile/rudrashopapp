// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';
import 'dart:ffi';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/http/model/variant_products_response.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_dialog.dart';
import 'package:rudrashop/utils/app_fonts.dart';
import 'package:http/http.dart' as http;

class ProductsDetails extends StatefulWidget {
  String? pId;
  String? categoryId;
  String? categoryName;
  String? subCategoryId;
  String? subCategoryName;
  String? sub3CategoryId;
  String? sub3CategoryName;
  String? productName;
  String? productSp;
  String? productMrp;
  String? pGst;
  String? discount;
  String? productMoq;
  String? productsDic;
  String? image1;
  String? image2;
  String? image3;

  ProductsDetails({
    super.key,
    required this.pId,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.sub3CategoryId,
    required this.sub3CategoryName,
    required this.productName,
    required this.productSp,
    required this.productMrp,
    required this.pGst,
    required this.discount,
    required this.productMoq,
    required this.productsDic,
    required this.image1,
    required this.image2,
    required this.image3,
  });

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Provider.of<ProductsDetailsModel>(context, listen: false)
            .setImageInSlider(
                widget.image1 ?? "", widget.image2 ?? "", widget.image3 ?? "");
        await Provider.of<ProductsDetailsModel>(context, listen: false)
            .getVariantProducts(widget.pId ?? "", context);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.black7,
        appBar: AppBar(
          title: const Text("Back"),
          backgroundColor: AppColor.mainColor,
        ),
        body: Consumer<ProductsDetailsModel>(builder: (context, products, _) {
          return WillPopScope(
            onWillPop: () async {
              products.setListNull();
              return true;
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (products.imageList?.isNotEmpty ?? false)
                      ? CarouselSlider(
                          items: products.imageList
                              ?.map(
                                (e) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://drive.google.com/uc?id=${e ?? ""}"),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          carouselController: products.carouselController,
                          options: CarouselOptions(
                            scrollPhysics: const BouncingScrollPhysics(),
                            autoPlay: true,
                            aspectRatio: 1,
                            viewportFraction: 1,
                          ),
                        )
                      : Container(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: AppColor.black2,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Add minimum ${widget.productMoq} pcs to purchase",
                        style: AppFonts.semiBoldWhite,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: AppColor.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName ?? "",
                            style: AppFonts.semiBoldBlack,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Product Description : ",
                            style: AppFonts.textFieldLabelGary,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          products.readMore
                              ? Text(
                                  widget.productsDic ?? "",
                                )
                              : Text(
                                  widget.productsDic ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(color: AppColor.black2),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  products.readMoreTrueFalse();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColor.black5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      products.readMore
                                          ? "Read Less"
                                          : "Read More",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Select Models :",
                      style: AppFonts.semiBoldBlack,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.productsList.length,
                    itemBuilder: (context, int index) {
                      VariantProductData? vProduct =
                          products.productsList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              vProduct.variantName ?? "",
                                              style: AppFonts.regularBlack,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "₹ ${vProduct.productSp.toString() ?? ""} per pc",
                                              style: AppFonts.semiBoldBlack,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              "Min Qty : ${vProduct.productMoq.toString() ?? ""} pcs",
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: AppColor.black5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.remove,
                                            size: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(products.productsList[index].qty
                                                .toString()),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            products.qtyMinus(
                                                int.parse(
                                                    vProduct.productMoq ?? "0"),
                                                vProduct.qty ?? 0);
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            size: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ProductsDetailsModel extends ChangeNotifier {
  List<String>? imageList = [];
  List<VariantProductData> productsList = [];
  int qty = 0;
  bool readMore = false;

  final CarouselController carouselController = CarouselController();

  getVariantProducts(String productId, BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog());
    String url = "${AppConstant.GET_VARIANT_OF_PRODUCTS}?productId=$productId";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Navigator.pop(context);

      var jsonData = json.decode(response.body);

      if (jsonData["status"] ?? false) {
        var data = VariantProductsResponse.fromJson(jsonData);
        if (data.variantProducts != []) {
          productsList = data.variantProducts ?? [];
          notifyListeners();
        } else {}
      }
    } else {
      Navigator.pop(context);
    }
  }

  setImageInSlider(String image0, String image1, String image2) {
    if (image0.isNotEmpty || image0 != "") {
      imageList?.add(image0);
    }
    if (image1.isNotEmpty || image1 != "") {
      imageList?.add(image1);
    }
    if (image2.isNotEmpty || image2 != "") {
      imageList?.add(image2);
    }
    notifyListeners();
  }

  qtyAdd(int mQty) {
    qty = mQty++;
    notifyListeners();
  }

  int qtyMinus(int mQty, int sQty) {
    print("$mQty $sQty");

    int qty = sQty + mQty;

    notifyListeners();
    return qty;
  }

  setListNull() {
    qty = 0;
    imageList = [];
    productsList = [];
    notifyListeners();
  }

  readMoreTrueFalse() {
    if (readMore) {
      readMore = false;
      notifyListeners();
    } else {
      readMore = true;
      notifyListeners();
    }
  }
}
