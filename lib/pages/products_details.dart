// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_fonts.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<ProductsDetailsModel>(context, listen: false).setImageInSlider(widget.image1 ?? "", widget.image2 ?? "", widget.image3 ?? "");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.black7,
        bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          color: AppColor.black2,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Add ${widget.productMoq} pcs to purchase",
              style: AppFonts.semiBoldWhite,
              textAlign: TextAlign.center,
            ),
          ),
        ),
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
                                    image: NetworkImage("https://drive.google.com/uc?id=${e ?? ""}"),
                                    fit: BoxFit.fill,
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
                          height: 10,
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
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColor.black5),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    products.readMore ? "Read More" : "Read Less",
                                    style: AppFonts.semiBoldBlack,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*Row(
                          children: [
                            Text(
                              "₹${widget.productSp ?? ""}",
                              style: AppFonts.mediumGray20,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(color: AppColor.mainColor, borderRadius: BorderRadius.circular(25)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "-${widget.productSp ?? ""} OFF",
                                  style: AppFonts.semiBoldWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "₹${widget.productSp ?? ""}",
                          style: AppFonts.mediumMainRed20,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Min Qty : ${widget.productMoq.toString() ?? ""} pcs",
                          style: AppFonts.regularBlack,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),*/
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class ProductsDetailsModel extends ChangeNotifier {
  List<String>? imageList = [];
  bool readMore = false;

  final CarouselController carouselController = CarouselController();

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

  setListNull() {
    imageList = [];
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
