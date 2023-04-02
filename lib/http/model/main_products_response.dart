// To parse this JSON data, do
//
//     final mainProductsResponse = mainProductsResponseFromJson(jsonString);

import 'dart:convert';

MainProductsResponse mainProductsResponseFromJson(String str) =>
    MainProductsResponse.fromJson(json.decode(str));

String mainProductsResponseToJson(MainProductsResponse data) =>
    json.encode(data.toJson());

class MainProductsResponse {
  MainProductsResponse({
    this.status,
    this.message,
    this.mainProducts,
  });

  bool? status;
  String? message;
  List<MainProductData>? mainProducts;

  factory MainProductsResponse.fromJson(Map<String, dynamic> json) =>
      MainProductsResponse(
        status: json["status"],
        message: json["message"],
        mainProducts: List<MainProductData>.from(
            json["mainProducts"].map((x) => MainProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "mainProducts":
            List<dynamic>.from(mainProducts?.map((x) => x.toJson()) ?? []),
      };
}

class MainProductData {
  MainProductData({
    this.pId,
    this.categoryId,
    this.categoryName,
    this.subCategoryId,
    this.subCategoryName,
    this.sub3CategoryId,
    this.sub3CategoryName,
    this.productName,
    this.productMrp,
    this.productSp,
    this.pGst,
    this.discount,
    this.productMoq,
    this.productsDics,
    this.image1,
    this.image2,
    this.image3,
  });

  String? pId;
  String? categoryId;
  String? categoryName;
  String? subCategoryId;
  String? subCategoryName;
  String? sub3CategoryId;
  String? sub3CategoryName;
  String? productName;
  int? productMrp;
  int? productSp;
  int? pGst;
  int? discount;
  int? productMoq;
  String? productsDics;
  String? image1;
  String? image2;
  String? image3;

  factory MainProductData.fromJson(Map<String, dynamic> json) => MainProductData(
        pId: json["p_id"],
        categoryId: json["category_id"],
        categoryName: json["categoryName"],
        subCategoryId: json["subCategory_id"],
        subCategoryName: json["subCategoryName"],
        sub3CategoryId: json["sub3CategoryId"],
        sub3CategoryName: json["sub3CategoryName"],
        productName: json["productName"],
        productMrp: json["productMrp"],
        productSp: json["productSp"],
        pGst: json["pGst"],
        discount: json["discount"],
        productMoq: json["productMoq"],
        productsDics: json["productsDics"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
      );

  Map<String, dynamic> toJson() => {
        "p_id": pId,
        "category_id": categoryId,
        "categoryName": categoryName,
        "subCategory_id": subCategoryId,
        "subCategoryName": subCategoryName,
        "sub3CategoryId": sub3CategoryId,
        "sub3CategoryName": sub3CategoryName,
        "productName": productName,
        "productMrp": productMrp,
        "productSp": productSp,
        "pGst": pGst,
        "discount": discount,
        "productMoq": productMoq,
        "productsDics": productsDics,
        "image1": image1,
        "image2": image2,
        "image3": image3,
      };
}
