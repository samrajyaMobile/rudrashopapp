// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/http/model/banners_response.dart';
import 'package:rudrashop/http/model/clearance_products_response.dart';
import 'package:rudrashop/http/model/deal_products_response.dart';
import 'package:rudrashop/http/model/main_category_response.dart';
import 'package:rudrashop/http/model/new_arrival_products_response.dart';
import 'package:rudrashop/http/model/products_response.dart';
import 'package:rudrashop/http/model/slider_data_response.dart';
import 'package:rudrashop/pages/deal_products.dart';
import 'package:rudrashop/pages/new_arrivals_products.dart';
import 'package:rudrashop/pages/products_details.dart';
import 'package:rudrashop/pages/sub3_category.dart';
import 'package:rudrashop/pages/sub_categoty.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:rudrashop/utils/app_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Provider.of<HomeModel>(context, listen: false).getSlider(context);
        await Provider.of<HomeModel>(context, listen: false).getCategories(context);
        await Provider.of<HomeModel>(context, listen: false).getDeal(context);
        await Provider.of<HomeModel>(context, listen: false).getNewArrivals(context);
        await Provider.of<HomeModel>(context, listen: false).getClearance(context);
        await Provider.of<HomeModel>(context, listen: false).getBanners();
      },
    );
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
                      (home.sliderList?.isNotEmpty ?? false)
                          ? CarouselSlider(
                              items: home.sliderList
                                  ?.map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (e.navigationPage?.toLowerCase() == "products" || e.navigationPage?.toLowerCase() == "product") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ProductsDetails(
                                                          pId: e.pId,
                                                          categoryId: e.categoryId,
                                                          categoryName: e.categoryName,
                                                          subCategoryId: e.subCategoryId,
                                                          subCategoryName: e.subCategoryName,
                                                          sub3CategoryId: e.sub3CategoryId,
                                                          sub3CategoryName: e.sub3CategoryName,
                                                          productName: e.productName,
                                                          productSp: e.productSp,
                                                          pGst: e.pGst,
                                                          discount: e.discount,
                                                          productMoq: e.productMoq,
                                                          productsDic: e.productsDic,
                                                          image1: e.image1,
                                                          image2: e.image2,
                                                          image3: e.image3,
                                                          productMrp: e.productMrp,
                                                        )));
                                          } else if (e.navigationPage?.toLowerCase() == "deal") {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DealProducts()));
                                          } else if (e.navigationPage?.toLowerCase() == "newproducts" || e.navigationPage?.toLowerCase() == "newproducts") {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => const NewArrivalsProducts()));
                                          } else if (e.navigationPage?.toLowerCase() == "clearance") {
                                          } else if (e.navigationPage?.toLowerCase() == "subcategory" || e.navigationPage?.toLowerCase() == "subcategories") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => SubCategoryScreen(categoryName: e.categoryName, categoryId: e.categoryId)));
                                          } else if (e.navigationPage?.toLowerCase() == "sub3category" || e.navigationPage?.toLowerCase() == "sub3categories") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Sub3Category(subCategoryName: e.subCategoryName, subCategoryId: e.subCategoryId)));
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: AppColor.black5,
                                            ),
                                            image: DecorationImage(
                                                image: NetworkImage("https://drive.google.com/uc?export=view&id=${e.sliderImages ?? ""}"), fit: BoxFit.fill),
                                          ),
                                        ),
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
                Container(
                  color: AppColor.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              "assets/images/dealoftheday.svg",
                              width: MediaQuery.of(context).size.width / 2.5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const DealProducts()));
                              },
                              child: Row(
                                children: [
                                  const Text("View more"),
                                  Icon(
                                    Icons.play_arrow_rounded,
                                    color: AppColor.mainColor,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: (home.dealProductsList?.isNotEmpty ?? false) ? 5 : 0,
                            itemBuilder: (context, int index) {
                              DealProductData? products = home.dealProductsList?[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(color: AppColor.black5),
                                                image: DecorationImage(image: NetworkImage("https://drive.google.com/uc?id=${products?.image1 ?? ""}"))),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              products?.subCategoryName ?? "",
                                              style: AppFonts.regularBlack,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              products?.productName ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "₹${products?.productSp ?? ""}",
                                                  style: AppFonts.mediumMainRed,
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
                                                      "${products?.discount ?? ""}% Off",
                                                      style: AppFonts.semiBoldWhite12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                (home.bannersList == [])
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: (home.bannersList.isNotEmpty)
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColor.black5,
                                  ),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        "https://drive.google.com/uc?id=${home.bannersList[0].bannerImages ?? ""}",
                                      ),
                                      fit: BoxFit.fill),
                                ),
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                              )
                            : Container(),
                      ),
                Container(
                  color: AppColor.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              "assets/images/newarrivals.svg",
                              width: MediaQuery.of(context).size.width / 2.5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const NewArrivalsProducts()));
                              },
                              child: Row(
                                children: [
                                  const Text("View more"),
                                  Icon(
                                    Icons.play_arrow_rounded,
                                    color: AppColor.mainColor,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: (home.newArrivalProductsList?.isNotEmpty ?? false) ? 5 : 0,
                            itemBuilder: (context, int index) {
                              NewArrivalProductData? products = home.newArrivalProductsList?[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(color: AppColor.black5),
                                                image: DecorationImage(image: NetworkImage("https://drive.google.com/uc?id=${products?.image1 ?? ""}"))),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              products?.subCategoryName ?? "",
                                              style: AppFonts.regularBlack,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              products?.productName ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "₹${products?.productSp ?? ""}",
                                                  style: AppFonts.mediumMainRed,
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
                                                      "${products?.discount ?? ""}% Off",
                                                      style: AppFonts.semiBoldWhite12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                (home.bannersList == [])
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: (home.bannersList.length > 1)
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColor.black5,
                                  ),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        "https://drive.google.com/uc?id=${home.bannersList[1].bannerImages ?? ""}",
                                      ),
                                      fit: BoxFit.fill),
                                ),
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                              )
                            : Container(),
                      ),
                Container(
                  color: AppColor.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              "assets/images/clearncestock.svg",
                              width: MediaQuery.of(context).size.width / 2.5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const NewArrivalsProducts()));
                              },
                              child: Row(
                                children: [
                                  const Text("View more"),
                                  Icon(
                                    Icons.play_arrow_rounded,
                                    color: AppColor.mainColor,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: (home.clearanceProductsList?.isNotEmpty ?? false) ? 5 : 0,
                            itemBuilder: (context, int index) {
                              ClearanceProductData? products = home.clearanceProductsList?[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(color: AppColor.black5),
                                                image: DecorationImage(image: NetworkImage("https://drive.google.com/uc?id=${products?.image1 ?? ""}"))),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              products?.subCategoryName ?? "",
                                              style: AppFonts.regularBlack,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              products?.productName ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "₹${products?.productSp ?? ""}",
                                                  style: AppFonts.mediumMainRed,
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
                                                      "${products?.discount ?? ""}% Off",
                                                      style: AppFonts.semiBoldWhite12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                (home.bannersList == [])
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: (home.bannersList.length > 2)
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColor.black5,
                                  ),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        "https://drive.google.com/uc?id=${home.bannersList[2].bannerImages ?? ""}",
                                      ),
                                      fit: BoxFit.fill),
                                ),
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                              )
                            : Container(),
                      ),
                Container(
                  color: AppColor.white,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: 50,
                    itemBuilder: (context, int index) {
                      //ProductData? products = home.productsList?[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: AppColor.black5),
                                        image: const DecorationImage(
                                            image: NetworkImage("https://www.pngkit.com/png/full/283-2833454_transparent-mobile-accessories-png.png"))),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Xyx",
                                      style: AppFonts.regularBlack,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Text(
                                      "Xyz Name",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "₹20",
                                          style: AppFonts.mediumMainRed,
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
                                              "5% Off",
                                              style: AppFonts.semiBoldWhite12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
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

class HomeModel extends ChangeNotifier {
  List<SliderData>? sliderList = [];
  List<ProductData>? productsList = [];
  List<DealProductData>? dealProductsList = [];
  List<NewArrivalProductData>? newArrivalProductsList = [];
  List<ClearanceProductData>? clearanceProductsList = [];
  List<BannerData> bannersList = [];
  List<CategoryData>? categoryList = [];
  final CarouselController carouselController = CarouselController();

  bool sliderApi = false, categoriesApi = false, dealApi = false, newArrivalsApi = false, clearanceApi = false, bannersApi = false;

  getSlider(BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: false);
    var response = await http.get(Uri.parse(AppConstant.GET_SLIDERS));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      if (jsonData["status"] ?? false) {
        var finalData = SliderDataResponse.fromJson(jsonData);
        sliderList = finalData.sliders ?? [];
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

  getDeal(BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: false);
    var response = await http.get(Uri.parse(AppConstant.GET_DEAL_OF_THE_DAY));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      if (jsonData["status"] ?? false) {
        var finalData = DealProductsResponse.fromJson(jsonData);
        dealProductsList = finalData.mainProducts ?? [];
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

  getNewArrivals(BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: false);
    var response = await http.get(Uri.parse(AppConstant.GET_NEW_ARRIVALS));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      if (jsonData["status"] ?? false) {
        var finalData = NewArrivalProductsResponse.fromJson(jsonData);
        newArrivalProductsList = finalData.products ?? [];
        notifyListeners();
      } else {
        newArrivalProductsList = [];
        notifyListeners();
      }
    } else {
      Navigator.pop(context);
      newArrivalProductsList = [];
      notifyListeners();
    }
  }

  getClearance(BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: false);
    var response = await http.get(Uri.parse(AppConstant.GET_CLEARANCE));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      if (jsonData["status"] ?? false) {
        var finalData = ClearanceProductsResponse.fromJson(jsonData);
        clearanceProductsList = finalData.products ?? [];
        notifyListeners();
      } else {
        clearanceProductsList = [];
        notifyListeners();
      }
    } else {
      Navigator.pop(context);
      clearanceProductsList = [];
      notifyListeners();
    }
  }

  getBanners() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(AppConstant.GET_BANNERS));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var data = BannersResponse.fromJson(jsonData);
      if (data.banners != []) {
        bannersList.addAll(data.banners ?? []);
        sharedPreferences.setString(SharedPrefConstant.BANNERS, json.encode(data.banners));
        notifyListeners();
      }
    } else {}
  }
}
