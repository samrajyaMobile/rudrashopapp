// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rudrashop/http/model/sub_category_response.dart';
import 'package:rudrashop/pages/sub3_category.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_fonts.dart';

class SubCategoryScreen extends StatefulWidget {
  String? categoryName;
  String? categoryId;

  SubCategoryScreen(
      {super.key, required this.categoryName, required this.categoryId});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<SubCategoryModel>(context, listen: false)
          .getSubCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<SubCategoryModel>(builder: (context, subCategory, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.mainColor,
            title: Text(widget.categoryName ?? ""),
          ),
          body: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  shrinkWrap: true,
                  itemCount: subCategory.subCategoryList.length,
                  itemBuilder: (context, int index) {
                    SubCategoryData subCate =
                        subCategory.subCategoryList[index];

                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Sub3Category(subCategoryName: subCate.subCategoryName, subCategoryId: subCate.subCategoryName)));
                      },

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColor.black7),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    "https://drive.google.com/uc?id=${subCate.subCategoryImage ?? ""}",
                                    scale: 6,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(child: Text(subCate.subCategoryName ?? "",style: AppFonts.textFieldLabelBlack,textAlign: TextAlign.center,))
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
    );
  }
}

class SubCategoryModel extends ChangeNotifier {
  List<SubCategoryData> subCategoryList = [];

  getSubCategory() async {
    var response = await http.get(Uri.parse(AppConstant.POST_SUB_CATEGORIES));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      if (jsonData["status"] ?? false) {
        var data = SubCategoryResponse.fromJson(jsonData);

        if (data.status ?? false) {
          subCategoryList = data.subCategory ?? [];
          notifyListeners();
        } else {}
      } else {}
    } else {
      print("Nikesh");
    }
  }
}
