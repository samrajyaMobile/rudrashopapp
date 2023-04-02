// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/utils/app_colors.dart';

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
    Provider.of<ProductsDetailsModel>(context, listen: false).setImageInSlider(
        widget.image1 ?? "", widget.image2 ?? "", widget.image3 ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Back"),
          backgroundColor: AppColor.mainColor,
        ),
        body: Consumer<ProductsDetailsModel>(builder: (context, products, _) {
          return Column(
            children: [
              (products.imageList?.isNotEmpty ?? false)
                  ? CarouselSlider(
                      items: products.imageList
                          ?.map((e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://drive.google.com/uc?id=${e ?? ""}"),
                                          fit: BoxFit.fill)),
                                ),
                              ))
                          .toList(),
                      carouselController: products.carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2,
                        viewportFraction: 1,
                      ),
                    )
                  : Container(),
            ],
          );
        }),
      ),
    );
  }
}

class ProductsDetailsModel extends ChangeNotifier {
  List<String>? imageList = [];

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
  }
}
