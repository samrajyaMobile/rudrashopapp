// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rudrashop/http/model/sub_category_response.dart';
import 'package:rudrashop/pages/products.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:rudrashop/utils/app_constant.dart';
import 'package:html/parser.dart';
import 'package:rudrashop/utils/app_dialog.dart';
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
          .getSubCategory(widget.categoryId ?? "", context);
    });
    super.initState();
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text ?? "").documentElement?.text ?? "";

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<SubCategoryModel>(builder: (context, subCategory, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          appBar: AppBar(
            backgroundColor: AppColor.mainColor,
            title: Text(_parseHtmlString(widget.categoryName ?? "")),
          ),
          body: WillPopScope(
            onWillPop: () async {
              subCategory.makeListNull();
              return true;
            },
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    shrinkWrap: true,
                    itemCount: subCategory.list.length,
                    itemBuilder: (context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Products(
                                        categoryId: subCategory.list[index]
                                                ["id"]
                                            .toString(),
                                        categoryName: subCategory.list[index]
                                            ["name"],
                                      )));
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
                                    child: SizedBox(
                                      child: Image.network(
                                        subCategory.list[index]["image"] == null
                                            ? "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg"
                                            : subCategory.list[index]["image"]
                                                ["src"],
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Text(
                                      subCategory.list[index]["name"],
                                      style: AppFonts.textFieldLabelBlack,
                                      textAlign: TextAlign.center,
                                    ),
                                  )
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
          ),
        );
      }),
    );
  }
}

class SubCategoryModel extends ChangeNotifier {
  List<dynamic> list = [];

  getSubCategory(String categoryId, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => const LoadingDialog(),
        barrierDismissible: false);

    var url =
        "https://samrajya.co.in/index.php/wp-json/wc/v3/products/categories?consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&per_page=100&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637&parent=$categoryId&page=1";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var jsonData = json.decode(response.body);
      list = List<dynamic>.from(jsonData);
      notifyListeners();
    } else {
      Navigator.pop(context);
      makeListNull();
    }
  }

  makeListNull() {
    list = [];
    notifyListeners();
  }
}
