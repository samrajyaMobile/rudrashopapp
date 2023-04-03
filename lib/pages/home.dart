// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/http/model/main_category_response.dart';
import 'package:rudrashop/http/model/products_response.dart';
import 'package:rudrashop/http/model/slider_data_response.dart';
import 'package:rudrashop/pages/sub_categoty.dart';
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
      await Provider.of<HomeModel>(context, listen: false).getCategories(context);
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
                                ?.map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: NetworkImage("https://drive.google.com/uc?export=view&id=${e.sliderImages ?? ""}"), fit: BoxFit.fill)),
                                    ),
                                  ),
                                )
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
                                              categoryId: category?.categoryId ?? "",
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: Image.network(
                                        "https://drive.google.com/uc?id=${category?.categoryImage ?? ""}",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      category?.categoryName ?? "",
                                      style: TextStyle(color: AppColor.black1, fontSize: 12),
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
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: false);
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
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: false);

    var response = await http.get(Uri.parse(AppConstant.GET_CATEGORIES));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      if (jsonData["status"] ?? false) {
        var finalData = MainCategoryResponse.fromJson(jsonData);
        categoryList = finalData.category ?? [];
        notifyListeners();
      } else {
        categoryList = [];
        notifyListeners();
      }
    } else {
      Navigator.pop(context);
      categoryList = [];
      notifyListeners();
    }
  }
}
