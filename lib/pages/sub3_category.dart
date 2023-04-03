// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rudrashop/http/model/sub3_category_response.dart';
import 'package:rudrashop/pages/main_products.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_fonts.dart';

import '../utils/app_dialog.dart';

// ignore: must_be_immutable
class Sub3Category extends StatefulWidget {
  String? subCategoryName;
  String? subCategoryId;

  Sub3Category({super.key, required this.subCategoryName, required this.subCategoryId});

  @override
  State<Sub3Category> createState() => _Sub3CategoryState();
}

class _Sub3CategoryState extends State<Sub3Category> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<Sub3CategoryModel>(context, listen: false).getSub3Category(widget.subCategoryId ?? "", context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<Sub3CategoryModel>(builder: (context, sub3Category, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.mainColor,
            title: Text(widget.subCategoryName ?? ""),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Select type of ${widget.subCategoryName} : ",
                    style: AppFonts.semiBoldBlack,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 1),
                    shrinkWrap: true,
                    itemCount: sub3Category.sub3CategoryList.length,
                    itemBuilder: (context, int index) {
                      Sub3CategoryData subCate = sub3Category.sub3CategoryList[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainProductsList(
                                sub3CategoryId: subCate.sub3CategoryId,
                                sub3CategoryName: subCate.sub3CategoryName,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColor.black7),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    "https://drive.google.com/uc?id=${subCate.sub3CategoryImage ?? ""}",
                                    scale: 15,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        subCate.sub3CategoryName ?? "",
                                        style: AppFonts.textFieldLabelBlack,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class Sub3CategoryModel extends ChangeNotifier {

  List<Sub3CategoryData> sub3CategoryList = [];

  getSub3Category(String subCategoryId, BuildContext context) async {
    print(subCategoryId);
    showDialog(context: context, builder: (context) => const LoadingDialog(), barrierDismissible: false);
    var url = "${AppConstant.GET_SUB3_CATEGORIES}${QueryParamsConstant.SUB_CATEGORY_ID}=$subCategoryId";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);

      if (jsonData["status"] ?? false) {
        var data = Sub3CategoryResponse.fromJson(jsonData);
        if (data.status ?? false) {
          sub3CategoryList = data.sub3Category ?? [];
          notifyListeners();
        } else {
          sub3CategoryList = [];
          notifyListeners();
        }
      } else {
        sub3CategoryList = [];
        notifyListeners();
      }
    } else {
      Navigator.pop(context);
      sub3CategoryList = [];
      notifyListeners();
    }
  }
}
