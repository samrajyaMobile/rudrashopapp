// To parse this JSON data, do
//
//     final mainProductsResponse = mainProductsResponseFromJson(jsonString);

import 'dart:convert';

MainProductsResponse mainProductsResponseFromJson(String str) => MainProductsResponse.fromJson(json.decode(str));

String mainProductsResponseToJson(MainProductsResponse data) => json.encode(data.toJson());

class MainProductsResponse {
  MainProductsResponse({
    this.status,
    this.message,
    this.mainProducts,
  });

  bool? status;
  String? message;
  List<MainProductData>? mainProducts;

  factory MainProductsResponse.fromJson(Map<String, dynamic> json) => MainProductsResponse(
    status: json["status"],
    message: json["message"],
    mainProducts: List<MainProductData>.from(json["mainProducts"].map((x) => MainProductData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "mainProducts": List<dynamic>.from(mainProducts?.map((x) => x.toJson()) ?? []),
  };
}

class MainProductData {
  MainProductData({
    this.sub3CategoryId,
    this.sub3CategoryName,
    this.subCategoryId,
    this.subCategoryName,
    this.categoryId,
    this.categoryName,
    this.pId,
    this.productName,
    this.productMrp,
    this.productSp,
    this.pGst,
    this.discount,
    this.productMoq,
    this.productsDescr,
    this.image1,
    this.image2,
    this.image3,
  });

  String? sub3CategoryId;
  String? sub3CategoryName;
  String? subCategoryId;
  String? subCategoryName;
  String? categoryId;
  String? categoryName;
  String? pId;
  String? productName;
  String? productMrp;
  String? productSp;
  String? pGst;
  String? discount;
  String? productMoq;
  String? productsDescr;
  String? image1;
  String? image2;
  String? image3;

  factory MainProductData.fromJson(Map<String, dynamic> json) => MainProductData(
    sub3CategoryId: json["sub3CategoryId"],
    sub3CategoryName: json["sub3CategoryName"],
    subCategoryId: json["subCategoryId"],
    subCategoryName: json["subCategoryName"],
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    pId: json["pId"],
    productName: json["productName"],
    productMrp: json["productMrp"],
    productSp: json["productSp"],
    pGst: json["pGst"],
    discount: json["discount"],
    productMoq: json["productMoq"],
    productsDescr: json["productsDescr"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
  );

  Map<String, dynamic> toJson() => {
    "sub3CategoryId": sub3CategoryId,
    "sub3CategoryName": sub3CategoryName,
    "subCategoryId": subCategoryId,
    "subCategoryName": subCategoryName,
    "categoryId": categoryId,
    "categoryName": categoryName,
    "pId": pId,
    "productName": productName,
    "productMrp": productMrp,
    "productSp": productSp,
    "pGst": pGst,
    "discount": discount,
    "productMoq": productMoq,
    "productsDescr": productsDescr,
    "image1": image1,
    "image2": image2,
    "image3": image3,
  };
}
