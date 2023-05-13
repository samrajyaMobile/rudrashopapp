// ignore_for_file: must_be_immutable, use_build_context_synchronously, depend_on_referenced_packages

import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/dfareporting/v3_4.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/http/model/add_to_cart_model.dart';
import 'package:rudrashop/http/model/variations_products.dart';
import 'package:rudrashop/pages/cart.dart';
import 'package:rudrashop/pages/related_products_details.dart';
import 'package:rudrashop/utils/app_colors.dart';
import 'package:rudrashop/utils/app_constant.dart';
import 'package:rudrashop/utils/app_dialog.dart';
import 'package:rudrashop/utils/app_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:html/parser.dart';

class ProductsDetails extends StatefulWidget {
  String? pId;

  ProductsDetails({
    super.key,
    required this.pId,
  });

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        Provider.of<ProductsDetailsModel>(context, listen: false).getCartData();
        Provider.of<ProductsDetailsModel>(context, listen: false).setListNull();
        await Provider.of<ProductsDetailsModel>(context, listen: false).getProductsDetails(widget.pId ?? "", context);
        Provider.of<ProductsDetailsModel>(context, listen: false).setImageInSlider();
        Provider.of<ProductsDetailsModel>(context, listen: false).getVariantProducts(context);
        Provider.of<ProductsDetailsModel>(context, listen: false).getRelatedProducts(context);
      },
    );

    super.initState();
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body?.text ?? "").documentElement?.text ?? "";
    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ProductsDetailsModel>(
        builder: (context, products, _) {
          return Scaffold(
            backgroundColor: AppColor.black7,
            appBar: AppBar(
              title: const Text("Back"),
              backgroundColor: AppColor.mainColor,
              actions: [
                Stack(
                  children: [
                    products.cartList.isNotEmpty
                        ? Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Text(
                                products.cartList.length.toString(),
                                style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
                        : Container(),
                    Center(
                      child: IconButton(
                        onPressed: () async {
                          var nav = await Navigator.push(context, MaterialPageRoute(builder: (context) => const Cart()));

                          if (nav != null) {
                            products.getCartData();
                          }
                        },
                        icon: const Icon(Icons.shopping_cart),
                      ),
                    ),
                  ],
                )
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (products.imageList.isNotEmpty)
                            ? CarouselSlider(
                                items: products.imageList
                                    .map(
                                      (e) => Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(e),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                carouselController: products.carouselController,
                                options: CarouselOptions(
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  autoPlay: true,
                                  aspectRatio: 1,
                                  viewportFraction: 1,
                                ),
                              )
                            : Container(),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: AppColor.black2,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Add minimum pcs to purchase",
                              style: AppFonts.semiBoldWhite,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: AppColor.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products.mainProductsJsonData?["name"] ?? "Product Name",
                                  style: AppFonts.semiBoldBlack,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Product Description : ",
                                  style: AppFonts.textFieldLabelGary,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                products.readMore
                                    ? Text(
                                        _parseHtmlString(products.mainProductsJsonData?["description"] ?? ""),
                                      )
                                    : Text(
                                        _parseHtmlString(products.mainProductsJsonData?["description"] ?? ""),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(color: AppColor.black2),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () {
                                        products.readMoreTrueFalse();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColor.black5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            products.readMore ? "Read Less" : "Read More",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Select Models :",
                            style: AppFonts.semiBoldBlack,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: products.vList.length,
                          itemBuilder: (context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "${products.vList[index].name}",
                                                    style: AppFonts.regularBlack,
                                                    maxLines: 4,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "₹ ${products.vList[index].price} per pc",
                                                    style: AppFonts.semiBoldBlack,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  products.vList[index].stock == "instock"
                                                      ? Text(
                                                          "Min Qty :${products.vList[index].minQty.toString()} pcs",
                                                          style: AppFonts.regularBlack,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        )
                                                      : Container(
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColor.red),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(
                                                              "Out of stock",
                                                              style: AppFonts.semiBoldWhite12,
                                                            ),
                                                          ),
                                                        ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(color: AppColor.black5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  int? availableStock = products.vList[index].availableStock;
                                                  if (availableStock == 0) {
                                                  } else {
                                                    if (products.vList[index].qty! != 0) {
                                                      var filteredList = products.cartList.where((val) => val.id == products.vList[index].id);
                                                      List<AddToCartModel> currentCartItem = List.from(filteredList);

                                                      if (currentCartItem.isNotEmpty) {
                                                        products.vList[index].qty =
                                                            currentCartItem[0].productQty! - int.parse(products.vList[index].minQty.toString());
                                                      } else {
                                                        products.vList[index].qty =
                                                            products.vList[index].qty! - int.parse(products.vList[index].minQty.toString());
                                                      }

                                                      AddToCartModel request = AddToCartModel(
                                                        id: products.vList[index].id ?? 0,
                                                        productQty: products.vList[index].qty,
                                                        image: products.vList[index].image ??
                                                            "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                                        qty: products.vList[index].qty,
                                                        name: products.vList[index].name,
                                                        pCategory: products.vList[index].pCategory ?? "",
                                                        price: double.parse(products.vList[index].price.toString()),
                                                      );

                                                      if (products.cartList.isEmpty) {
                                                        products.cartList.add(request);
                                                        products.setCartData(products.cartList);
                                                      } else {
                                                        bool isFound = false;
                                                        for (var i = 0; i < products.cartList.length; ++i) {
                                                          if (products.cartList[i].id == products.vList[index].id) {
                                                            isFound = true;
                                                            setState(() {
                                                              products.cartList[i].productQty = products.vList[index].qty!;
                                                            });
                                                            products.setCartData(products.cartList);
                                                            break;
                                                          }
                                                        }
                                                        if (!isFound) {
                                                          setState(() {
                                                            products.cartList.add(request);
                                                          });
                                                          products.setCartData(products.cartList);
                                                        }
                                                      }
                                                    } else {
                                                      var filteredList = products.cartList.where((val) => val.id == products.vList[index].id);
                                                      List<AddToCartModel> currentCartItem = List.from(filteredList);
                                                      if (currentCartItem.isNotEmpty) {
                                                        products.vList[index].qty =
                                                            currentCartItem[0].productQty! - int.parse(products.vList[index].minQty.toString());
                                                      } else {
                                                        products.vList[index].qty =
                                                            products.vList[index].qty! - int.parse(products.vList[index].minQty.toString());
                                                      }

                                                      AddToCartModel request = AddToCartModel(
                                                        id: products.vList[index].id ?? 0,
                                                        productQty: products.vList[index].qty,
                                                        image: products.vList[index].image ??
                                                            "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                                        qty: products.vList[index].qty,
                                                        name: products.vList[index].name,
                                                        pCategory: products.vList[index].pCategory ?? "",
                                                        price: double.parse(products.vList[index].price.toString()),
                                                      );
                                                      products.cartList.remove(request);
                                                    }
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 15,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: products.currentCartItem.isNotEmpty
                                                    ? Text(products.getCurrentQty(int.parse(products.vList[index].toString())).toString())
                                                    : Text("${products.vList[index].qty}"),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  int? availableStock = products.vList[index].availableStock;
                                                  if (availableStock == 0) {
                                                  } else {
                                                    if (products.vList[index].qty! < availableStock!) {
                                                      var filteredList = products.cartList.where((val) => val.id == products.vList[index].id);
                                                      List<AddToCartModel> currentCartItem = List.from(filteredList);

                                                      if (currentCartItem.isNotEmpty) {
                                                        products.vList[index].qty =
                                                            currentCartItem[0].productQty! + int.parse(products.vList[index].minQty.toString());
                                                      } else {
                                                        products.vList[index].qty =
                                                            products.vList[index].qty! + int.parse(products.vList[index].minQty.toString());
                                                      }

                                                      AddToCartModel request = AddToCartModel(
                                                        id: products.vList[index].id ?? 0,
                                                        productQty: products.vList[index].qty,
                                                        image: products.vList[index].image ??
                                                            "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                                        qty: products.vList[index].qty,
                                                        name: products.vList[index].name,
                                                        pCategory: products.vList[index].pCategory ?? "",
                                                        price: double.parse(products.vList[index].price.toString()),
                                                      );

                                                      if (products.cartList.isEmpty) {
                                                        products.cartList.add(request);
                                                        products.setCartData(products.cartList);
                                                      } else {
                                                        bool isFound = false;
                                                        for (var i = 0; i < products.cartList.length; ++i) {
                                                          if (products.cartList[i].id == products.vList[index].id) {
                                                            isFound = true;
                                                            setState(() {
                                                              products.cartList[i].productQty = products.vList[index].qty!;
                                                            });
                                                            products.setCartData(products.cartList);
                                                            break;
                                                          }
                                                        }
                                                        if (!isFound) {
                                                          setState(() {
                                                            products.cartList.add(request);
                                                          });
                                                          products.setCartData(products.cartList);
                                                        }
                                                      }
                                                    }
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(
                            "Related Products :",
                            style: AppFonts.textFieldBlack,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: products.rList.length,
                            itemBuilder: (context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => RelatedProductsDetails(pId: products.rList[index].id)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context).size.height / 6,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: AppColor.black5),
                                              image: DecorationImage(
                                                image: NetworkImage(products.rList[index].image ?? ""),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                products.rList[index].pCategory ?? "",
                                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                products.rList[index].name ?? "",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              (products.rList[index].stock == "outofstock")
                                                  ? Container(
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColor.red),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "Out of stock",
                                                          style: AppFonts.semiBoldWhite12,
                                                        ),
                                                      ),
                                                    )
                                                  : Text(
                                                      "₹ ${products.rList[index].price}",
                                                      style: TextStyle(color: AppColor.red, fontSize: 18, fontWeight: FontWeight.w700),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProductsDetailsModel extends ChangeNotifier {
  Map<String, dynamic>? mainProductsJsonData;
  List<VariantProducts> vList = [];
  List<RelatedProducts> rList = [];
  List<AddToCartModel> cartList = [];
  List<AddToCartModel> currentCartItem = [];

  List<int> variationProductsId = [];
  List<int> relatedProductsId = [];
  List<String> imageList = [];

  bool readMore = false;
  double mainTotal = 0;

  final CarouselController carouselController = CarouselController();

  setCartData(List<AddToCartModel> list) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String strData = json.encode(list);
    preferences.setString(SharedPrefConstant.CART_LIST, strData);
  }

  getCartData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? strData = (preferences.getString(SharedPrefConstant.CART_LIST) ?? "");
    if (strData != "") {
      var jsonData = json.decode(strData);
      var list = List<dynamic>.from(jsonData);
      cartList = list.map((e) => AddToCartModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  getProductsDetails(String productId, BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog());
    String url =
        "https://samrajya.co.in/index.php/wp-json/wc/v3/products/$productId?consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      mainProductsJsonData = json.decode(response.body);
      notifyListeners();
    } else {
      Navigator.pop(context);
    }
  }

  getVariantProductsDetails(String productId, BuildContext context) async {
    String url =
        "https://samrajya.co.in/index.php/wp-json/wc/v3/products/$productId?consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      String? minQty;
      for (var i = 0; i < jsonData["meta_data"].length; ++i) {
        if (jsonData["meta_data"][i]["key"] == "_wcj_order_quantities_min") {
          minQty = jsonData["meta_data"][i]["value"];
          break;
        }
      }

      VariantProducts products = VariantProducts(
        id: jsonData["id"],
        name: jsonData["name"].toString(),
        qty: 0,
        minQty: minQty,
        price: jsonData["price"].toString(),
        stock: jsonData["stock_status"].toString(),
        availableStock: jsonData["stock_quantity"] ?? 0,
        image: jsonData["images"][0]["src"] ?? "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
        pCategory: jsonData["categories"].isNotEmpty ? jsonData["categories"][0]["name"] : "",
      );
      vList.add(products);
      notifyListeners();
    } else {}
  }

  int getCurrentQty(int index) {
    var filteredList = cartList.where((val) => val.id == vList[index].id);
    currentCartItem = List.from(filteredList);
    return currentCartItem[0].productQty ?? 0;
  }

  getRelatedProductsDetails(String productId, BuildContext context) async {
    String url =
        "https://samrajya.co.in/index.php/wp-json/wc/v3/products/$productId?consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      String? minQty;
      for (var i = 0; i < jsonData["meta_data"].length; ++i) {
        if (jsonData["meta_data"][i]["key"] == "_wcj_order_quantities_min") {
          minQty = jsonData["meta_data"][i]["value"];
          break;
        }
      }
      RelatedProducts products = RelatedProducts(
        id: jsonData["id"].toString(),
        name: jsonData["name"].toString(),
        qty: 0,
        minQty: minQty,
        price: jsonData["price"].toString(),
        stock: jsonData["stock_status"].toString(),
        image: jsonData["images"][0]["src"].toString(),
        pCategory: jsonData["categories"][0]["name"].toString(),
      );
      rList.add(products);
      notifyListeners();
    } else {}
  }

  getVariantProducts(BuildContext context) async {
    for (var i = 0; i < mainProductsJsonData?["variations"].length; ++i) {
      variationProductsId.add(mainProductsJsonData?["variations"][i]);
      await getVariantProductsDetails(mainProductsJsonData?["variations"][i].toString() ?? "", context);
    }
  }

  getRelatedProducts(BuildContext context) async {
    for (var i = 0; i < mainProductsJsonData?["related_ids"].length; ++i) {
      relatedProductsId.add(mainProductsJsonData?["related_ids"][i]);
      await getRelatedProductsDetails(mainProductsJsonData?["related_ids"][i].toString() ?? "", context);
    }
  }

  setImageInSlider() {
    for (var i = 0; i < mainProductsJsonData?["images"].length; ++i) {
      imageList.add(mainProductsJsonData?["images"][i]["src"]);
      notifyListeners();
    }
  }

  setListNull() {
    mainTotal = 0;
    imageList = [];
    vList = [];
    rList = [];
    notifyListeners();
  }

  readMoreTrueFalse() {
    if (readMore) {
      readMore = false;
      notifyListeners();
    } else {
      readMore = true;
      notifyListeners();
    }
  }
}
