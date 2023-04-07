// To parse this JSON data, do
//
//     final newArrivalProductsResponse = newArrivalProductsResponseFromJson(jsonString);

import 'dart:convert';

NewArrivalProductsResponse newArrivalProductsResponseFromJson(String str) => NewArrivalProductsResponse.fromJson(json.decode(str));

String newArrivalProductsResponseToJson(NewArrivalProductsResponse data) => json.encode(data.toJson());

class NewArrivalProductsResponse {
  NewArrivalProductsResponse({
    this.status,
    this.message,
    this.products,
  });

  bool? status;
  String? message;
  List<NewArrivalProductData>? products;

  factory NewArrivalProductsResponse.fromJson(Map<String, dynamic> json) => NewArrivalProductsResponse(
    status: json["status"],
    message: json["message"],
    products: List<NewArrivalProductData>.from(json["products"].map((x) => NewArrivalProductData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "products": List<dynamic>.from(products?.map((x) => x.toJson()) ?? []),
  };
}

class NewArrivalProductData {
  NewArrivalProductData({
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

  factory NewArrivalProductData.fromJson(Map<String, dynamic> json) => NewArrivalProductData(
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
