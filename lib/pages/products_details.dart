// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rudrashop/http/model/add_to_cart_model.dart';
import 'package:rudrashop/http/model/variant_products_response.dart';
import 'package:rudrashop/pages/cart.dart';
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
        await Provider.of<ProductsDetailsModel>(context, listen: false)
            .getProductsDetails(widget.pId ?? "", context);
        await Provider.of<ProductsDetailsModel>(context, listen: false)
            .setImageInSlider();
      },
    );

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
      child: Consumer<ProductsDetailsModel>(
        builder: (context, products, _) {
          return Scaffold(
            backgroundColor: AppColor.black7,
            appBar: AppBar(
              title: const Text("Back"),
              backgroundColor: AppColor.mainColor,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Cart()));
                    },
                    icon: const Icon(Icons.shopping_cart))
              ],
            ),
            body: WillPopScope(
              onWillPop: () async {
                products.setListNull();
                return true;
              },
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (products.imageList.isNotEmpty ?? false)
                              ? CarouselSlider(
                                  items: products.imageList
                                      .map(
                                        (e) => Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  e),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  carouselController:
                                      products.carouselController,
                                  options: CarouselOptions(
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
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
                                    products.jsonData["name"] ?? "",
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
                                          _parseHtmlString(products.jsonData["description"]),
                                        )
                                      : Text(
                                    _parseHtmlString(products.jsonData["description"]),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style:
                                              TextStyle(color: AppColor.black2),
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
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: AppColor.black5),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              products.readMore
                                                  ? "Read Less"
                                                  : "Read More",
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
                          /*ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: products.list.length,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      vProduct.variantName ??
                                                          "",
                                                      style:
                                                          AppFonts.regularBlack,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "₹ ${vProduct.productSp.toString()} per pc",
                                                      style: AppFonts
                                                          .semiBoldBlack,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      "Min Qty : ${vProduct.productMoq.toString()} pcs",
                                                      style:
                                                          AppFonts.regularBlack,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: AppColor.black5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(
                                                      () {
                                                        if ((vProduct.qty ??
                                                                0) <
                                                            1) {
                                                        } else {
                                                          vProduct
                                                              .qty = (vProduct
                                                                      .qty ??
                                                                  0) -
                                                              int.parse(vProduct
                                                                      .productMoq ??
                                                                  "0");

                                                          products.toMinus(
                                                            spPrice: double
                                                                .parse(vProduct
                                                                    .productSp
                                                                    .toString()),
                                                            gstPer: double
                                                                .parse(vProduct
                                                                    .pGst
                                                                    .toString()),
                                                            pImage: "",
                                                            pName: vProduct
                                                                    .productName ??
                                                                "",
                                                            pQty: vProduct.qty
                                                                    .toString() ??
                                                                "",
                                                            pTotal: products
                                                                    .mainTotal
                                                                    .toString() ??
                                                                "",
                                                            pModel: vProduct
                                                                    .variantName ??
                                                                "",
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    size: 15,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                vProduct.qty == null
                                                    ? const Text("0")
                                                    : Text(vProduct.qty
                                                        .toString()),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(
                                                      () {
                                                        vProduct.qty = (vProduct
                                                                    .qty ??
                                                                0) +
                                                            int.parse(vProduct
                                                                    .productMoq ??
                                                                "0");
                                                        products.toAdd(
                                                          spPrice: double.parse(
                                                              vProduct.productSp
                                                                  .toString()),
                                                          gstPer: double.parse(
                                                              vProduct.pGst
                                                                  .toString()),
                                                          pImage: "",
                                                          pName: vProduct
                                                                  .productName ??
                                                              "",
                                                          pQty: vProduct.qty
                                                                  .toString() ??
                                                              "",
                                                          pTotal: products
                                                                  .mainTotal
                                                                  .toString() ??
                                                              "",
                                                          pModel: vProduct
                                                                  .variantName ??
                                                              "",
                                                        );
                                                      },
                                                    );
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
                          )*/
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sub Total : ${products.subTotal.roundToDouble()} + GST ${products.gst.roundToDouble()} (${products.gstPercentage.roundToDouble()}%)",
                            ),
                            Text(
                              "Main Total : ${products.mainTotal.roundToDouble()}",
                              style: AppFonts.semiBoldBlack,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                backgroundColor: MaterialStateProperty.all(
                                    AppColor.mainColor),
                                overlayColor:
                                    MaterialStateProperty.all(Colors.white10),
                              ),
                              onPressed: () {
                                products.addToCart();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "Add to cart",
                                  style: TextStyle(color: AppColor.white),
                                ),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductsDetailsModel extends ChangeNotifier {
  var jsonData;

  List<dynamic> list = [];
  List<int> variationProductsId = [];
  List<int> variationProducts = [];
  List<String> imageList = [];
  bool readMore = false;
  double subTotal = 0;
  double mainTotal = 0;
  double gst = 0;
  double gstPercentage = 0;
  List<AddToCartModel> cartList = [];
  final CarouselController carouselController = CarouselController();

  getProductsDetails(String productId, BuildContext context) async {
    showDialog(context: context, builder: (context) => const LoadingDialog());
    String url =
        "https://samrajya.co.in/index.php/wp-json/wc/v3/products/$productId?consumer_key=ck_6fec19dc34310bf11f6a020ec2526f0075cdae8e&consumer_secret=cs_80ceaf6f10850003191baaf39da36f7ae1dcf637";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Navigator.pop(context);

      jsonData = json.decode(response.body);

      notifyListeners();
    } else {
      Navigator.pop(context);
    }
  }

  getVariantProducts() {
    for (var i = 0; i < list[0]["variations"]; ++i) {
      variationProductsId.add(list[0]["variations"][i]);
    }

    for (var i = 0; i < variationProductsId.length; ++i) {
      print(variationProductsId[i]);
    }
  }

  setImageInSlider() {
    for (var i = 0; i < jsonData["images"].length; ++i) {
      imageList.add(jsonData["images"][i]["src"]);
      notifyListeners();
    }
  }

  toAdd({
    required double spPrice,
    required double gstPer,
    required String pImage,
    required String pName,
    required String pModel,
    required String pQty,
    required String pTotal,
  }) {
    AddToCartModel addToCartModel = AddToCartModel(
      productImage: pImage,
      productName: pName,
      productQty: pQty,
      total: pTotal,
      productModel: pModel,
    );
    cartList.add(addToCartModel);
    gst = (spPrice * gstPer) / 100;
    subTotal = subTotal + spPrice;
    mainTotal = subTotal + gst;
    notifyListeners();
  }

  toMinus({
    required double spPrice,
    required double gstPer,
    required String pImage,
    required String pName,
    required String pQty,
    required String pModel,
    required String pTotal,
  }) {
    AddToCartModel addToCartModel = AddToCartModel(
      productImage: pImage,
      productName: pName,
      productQty: pQty,
      total: pTotal,
      productModel: pModel,
    );
    cartList.remove(addToCartModel);
    gst = (spPrice * gstPer) / 100;
    notifyListeners();
    subTotal = subTotal - spPrice;
  }
  setListNull() {
    subTotal = 0;
    mainTotal = 0;
    gst = 0;
    imageList = [];
    // productsList = [];
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

  addToCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var stringList = json.encode(cartList);
    sharedPreferences.setString(SharedPrefConstant.CART_LIST, stringList);
  }
}
