// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/http/model/main_category_response.dart';
import 'package:rudrashop/http/model/products_response.dart';
import 'package:rudrashop/http/model/slider_data_response.dart';
import 'package:rudrashop/pages/sun_categoty.dart';
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
      await Provider.of<HomeModel>(context, listen: false)
          .getCategories(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.black7,
      body: Consumer<HomeModel>(builder: (context, home, _) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColor.white,
                child: Column(
                  children: [
                    (home.bannerList?.isNotEmpty ?? false)
                        ? CarouselSlider(
                            items: home.bannerList
                                ?.map((e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://drive.google.com/uc?id=${e.sliderImages ?? ""}"),
                                                fit: BoxFit.fill)),
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
                    Container(
                      height: 120,
                      color: AppColor.white,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: home.categoryList?.length,
                          itemBuilder: (context, int index) {
                            CategoryData? category = home.categoryList?[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SubCategoryScreen(
                                              categoryName: category?.categoryName ?? "",
                                              categoryId: category?.categorySid ?? "",
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(
                                      "https://drive.google.com/uc?id=${category?.categoryImage ?? ""}",
                                      scale: 8,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      category?.categoryName ?? "",
                                      style: TextStyle(
                                          color: AppColor.black1, fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      MediaQuery.of(context).size.aspectRatio * 3 / 2,
                ),
                itemCount: home.productsList?.length,
                itemBuilder: (context, int index) {
                  ProductData? products = home.productsList?[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColor.mainColor)),
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
                                      decoration: BoxDecoration(
                                          color: AppColor.mainColor,
                                          borderRadius:
                                              BorderRadius.circular(25)),
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
    showDialog(
        context: context,
        builder: (context) => const LoadingDialog(),
        barrierDismissible: false);
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
    showDialog(
        context: context,
        builder: (context) => const LoadingDialog(),
        barrierDismissible: false);

    print("Nikesh1111");
    var response = await http.get(Uri.parse(AppConstant.GET_CATEGORIES));

    print("Nikesh");
    print(response.body);

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
}
