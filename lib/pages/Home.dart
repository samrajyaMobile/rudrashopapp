// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/http/model/main_category_response.dart';
import 'package:rudrashop/http/model/products_response.dart';
import 'package:rudrashop/http/model/slider_data_response.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:rudrashop/utils/app_fonts.dart';

import '../utils/app_colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeModel>(context, listen: false).getSlider(context);
      await Provider.of<HomeModel>(context, listen: false).getProducts(context);
      await Provider.of<HomeModel>(context, listen: false).getCategories(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Consumer<HomeModel>(builder: (context, home, _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (home.bannerList?.isNotEmpty ?? false)
                    ? CarouselSlider(
                        items: home.bannerList
                            ?.map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image:
                                            DecorationImage(image: NetworkImage("https://drive.google.com/uc?id=${e.sliderImages ?? ""}"), fit: BoxFit.fill)),
                                  ),
                                ))
                            .toList(),
                        carouselController: home.carouselController,
                        options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          aspectRatio: 2,
                          viewportFraction: 1,
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Categories :",
                    style: AppFonts.subTitle,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: home.categoryList?.length,
                      itemBuilder: (context, int index) {
                        CategoryData? category = home.categoryList?[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.mainColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  category?.categoryName ?? "",
                                  style: AppFonts.semiBoldWhite,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Products :",
                    style: AppFonts.subTitle,
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.aspectRatio * 3 / 2,
                  ),
                  itemCount: home.productsList?.length,
                  itemBuilder: (context, int index) {
                    ProductData? products = home.productsList?[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColor.mainColor)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    "https://drive.google.com/uc?id=${products?.productImage ?? ""}",
                                    scale: 2.5,
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
                                            "-${products?.discount.toString() ?? ""}%",
                                            style: AppFonts.semiBoldWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                products?.categoryName ?? "",
                                style: AppFonts.regularBlack,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                products?.productName ?? "",
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
                                    "₹ ${products?.productPrice.toString() ?? ""}",
                                    style: AppFonts.mainPrice,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "₹ ${products?.ourPrice.toString() ?? ""}",
                                    style: AppFonts.mediumMainColor,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
    ));
  }
}

class HomeModel extends ChangeNotifier {
  List<SliderData>? bannerList = [];
  List<ProductData>? productsList = [];
  List<CategoryData>? categoryList = [];
  final CarouselController carouselController = CarouselController();

  getSlider(BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog(),barrierDismissible: false);
    var response = await http.get(Uri.parse(AppConstant.GET_SLIDERS));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      if (jsonData["status"] ?? false) {
        var finalData = SliderDataResponse.fromJson(jsonData);
        bannerList = finalData.sliders ?? [];
        notifyListeners();
      }
    } else {
      Navigator.pop(context);
    }
  }

  getCategories(BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog(),barrierDismissible: false);
    var response = await http.get(Uri.parse(AppConstant.GET_CATEGORIES));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      if (jsonData["status"] ?? false) {
        var finalData = MainCategoryResponse.fromJson(jsonData);
        categoryList = finalData.categories ?? [];
        notifyListeners();
      }
    } else {
      Navigator.pop(context);
    }
  }

  getProducts(BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog(),barrierDismissible: false);
    var response = await http.get(Uri.parse(AppConstant.GET_PRODUCTS));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      if (jsonData["status"] ?? false) {
        var finalData = ProductsResponse.fromJson(jsonData);
        productsList = finalData.products ?? [];
        notifyListeners();
      }
    } else {
      Navigator.pop(context);
    }
  }
}
