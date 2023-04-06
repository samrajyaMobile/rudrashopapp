// To parse this JSON data, do
//
//     final sliderDataResponse = sliderDataResponseFromJson(jsonString);

import 'dart:convert';

SliderDataResponse sliderDataResponseFromJson(String str) => SliderDataResponse.fromJson(json.decode(str));

String sliderDataResponseToJson(SliderDataResponse data) => json.encode(data.toJson());

class SliderDataResponse {
  SliderDataResponse({
    this.status,
    this.message,
    this.sliders,
  });

  bool? status;
  String? message;
  List<SliderData>? sliders;

  factory SliderDataResponse.fromJson(Map<String, dynamic> json) => SliderDataResponse(
    status: json["status"],
    message: json["message"],
    sliders: List<SliderData>.from(json["sliders"].map((x) => SliderData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "sliders": List<dynamic>.from(sliders?.map((x) => x.toJson()) ?? []),
  };
}

class SliderData {
  SliderData({
    this.sliderId,
    this.sliderImages,
    this.navigationPage,
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
    this.productsDic,
    this.image1,
    this.image2,
    this.image3,
  });

  String? sliderId;
  String? sliderImages;
  String? navigationPage;
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
  String? productsDic;
  String? image1;
  String? image2;
  String? image3;

  factory SliderData.fromJson(Map<String, dynamic> json) => SliderData(
    sliderId: json["sliderId"],
    sliderImages: json["sliderImages"],
    navigationPage: json["navigationPage"],
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
    productsDic: json["productsDic"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
  );

  Map<String, dynamic> toJson() => {
    "sliderId": sliderId,
    "sliderImages": sliderImages,
    "navigationPage": navigationPage,
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
    "productsDic": productsDic,
    "image1": image1,
    "image2": image2,
    "image3": image3,
  };
}
