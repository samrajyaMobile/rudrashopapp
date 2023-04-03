// To parse this JSON data, do
//
//     final sub3CategoryResponse = sub3CategoryResponseFromJson(jsonString);

import 'dart:convert';

Sub3CategoryResponse sub3CategoryResponseFromJson(String str) => Sub3CategoryResponse.fromJson(json.decode(str));

String sub3CategoryResponseToJson(Sub3CategoryResponse data) => json.encode(data.toJson());

class Sub3CategoryResponse {
  Sub3CategoryResponse({
    this.status,
    this.message,
    this.sub3Category,
  });

  bool? status;
  String? message;
  List<Sub3CategoryData>? sub3Category;

  factory Sub3CategoryResponse.fromJson(Map<String, dynamic> json) => Sub3CategoryResponse(
    status: json["status"],
    message: json["message"],
    sub3Category: List<Sub3CategoryData>.from(json["sub3Category"].map((x) => Sub3CategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "sub3Category": List<dynamic>.from(sub3Category?.map((x) => x.toJson()) ?? []),
  };
}

class Sub3CategoryData {
  Sub3CategoryData({
    this.subCategoryId,
    this.sub3CategoryName,
    this.categoryId,
    this.categoryName,
    this.sub3CategoryId,
    this.subCategoryName,
    this.sub3CategoryImage,
  });

  String? subCategoryId;
  String? sub3CategoryName;
  String? categoryId;
  String? categoryName;
  String? sub3CategoryId;
  String? subCategoryName;
  String? sub3CategoryImage;

  factory Sub3CategoryData.fromJson(Map<String, dynamic> json) => Sub3CategoryData(
    subCategoryId: json["subCategoryId"],
    sub3CategoryName: json["sub3CategoryName"],
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    sub3CategoryId: json["sub3CategoryId"],
    subCategoryName: json["subCategoryName"],
    sub3CategoryImage: json["sub3CategoryImage"],
  );

  Map<String, dynamic> toJson() => {
    "subCategoryId": subCategoryId,
    "sub3CategoryName": sub3CategoryName,
    "categoryId": categoryId,
    "categoryName": categoryName,
    "sub3CategoryId": sub3CategoryId,
    "subCategoryName": subCategoryName,
    "sub3CategoryImage": sub3CategoryImage,
  };
}
