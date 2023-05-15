import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rudrashop/pages/sub_categoty.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:html/parser.dart' show parse;

class AllCategory extends StatefulWidget {
  const AllCategory({Key? key}) : super(key: key);

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AllCategoryModel>(context,listen: false).getAllCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AllCategoryModel>(
        builder: (context,cate,_) {
          return Scaffold(
            backgroundColor: AppColor.white,
            appBar: AppBar(
              backgroundColor: AppColor.mainColor,
              title: const Text("All Category" ?? ""),
            ),
            body: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: cate.categoryList.length,
                    itemBuilder: (context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubCategoryScreen(
                                categoryName:cate. categoryList[index]["name"],
                                categoryId: cate.categoryList[index]["id"].toString(),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColor.black7),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: SizedBox(
                                            child: Image.network(
                                              cate.categoryList[index]["image"] == null
                                                  ? "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg"
                                                  : cate.categoryList[index]["image"]["src"],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          cate._parseHtmlString(cate.categoryList[index]["name"]),
                                          style: const TextStyle(fontWeight: FontWeight.w700),
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
        }
      ),
    );
  }
}

class AllCategoryModel extends ChangeNotifier {
  List<dynamic> categoryList = [];
  getAllCategory() async {
    String url =
        "https://samrajya.co.in/index.php/wp-json/wc/v3/products/categories?orderby=count&order=desc&consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637&parent=0";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      categoryList = List<dynamic>.from(jsonData);
      notifyListeners();
    }
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text ?? "").documentElement?.text ?? "";

    return parsedString;
  }
}
