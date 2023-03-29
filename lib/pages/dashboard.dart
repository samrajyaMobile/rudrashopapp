import 'package:flutter/material.dart';
import 'package:rudrashop/http/model/slider_data_response.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:rudrashop/utils/app_constant.dart';
import 'dart:convert';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
      Provider.of<DashboardModel>(context, listen: false).getSlider(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardModel>(
      builder: (context, dashboard, _) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColor.mainColor,
              title: Image.asset(
                "assets/images/logo.png",
                scale: 12,
              ),
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                (dashboard.bannerList?.isNotEmpty ?? false) ? CarouselSlider(
                  items: dashboard.bannerList?.map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: NetworkImage("https://drive.google.com/uc?id=${e.sliderImages ?? ""}"),fit: BoxFit.fill)
                        ),
                    ),
                  )).toList(),
                  carouselController: dashboard.carouselController,
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    aspectRatio: 2,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      dashboard.changeIndex(index);
                    },
                  ),
                ): Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DashboardModel extends ChangeNotifier {
  int _currentIndex = 0;
  List<SliderData>? bannerList;
  List imagesList = [
    {"id": 1, "image_path": "assets/images/banner.jpg"},
    {"id": 2, "image_path": "assets/images/banner.jpg"},
    {"id": 3, "image_path": "assets/images/banner.jpg"},
  ];
  final CarouselController carouselController = CarouselController();

  getSlider(BuildContext context) async {
    var response = await http.get(Uri.parse(AppConstant.GET_SLIDERS));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData["status"] ?? false) {
        var finalData = SliderDataResponse.fromJson(jsonData);
        bannerList?.addAll(finalData.sliders ?? []);
        notifyListeners();
      }
    }
  }

  changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
