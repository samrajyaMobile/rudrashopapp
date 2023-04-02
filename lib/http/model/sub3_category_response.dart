// To parse this JSON data, do
//
//     final sub3CategoryResponse = sub3CategoryResponseFromJson(jsonString);

import 'dart:convert';

Sub3CategoryResponse sub3CategoryResponseFromJson(String str) =>
    Sub3CategoryResponse.fromJson(json.decode(str));

String sub3CategoryResponseToJson(Sub3CategoryResponse data) =>
    json.encode(data.toJson());

class Sub3CategoryResponse {
  Sub3CategoryResponse({
    this.status,
    this.message,
    this.sub3Category,
  });

  bool? status;
  String? message;
  List<Sub3CategoryData>? sub3Category;

  factory Sub3CategoryResponse.fromJson(Map<String, dynamic> json) =>
      Sub3CategoryResponse(
        status: json["status"],
        message: json["message"],
        sub3Category: List<Sub3CategoryData>.from(
            json["sub3Category"].map((x) => Sub3CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "sub3Category":
            List<dynamic>.from(sub3Category?.map((x) => x.toJson()) ?? []),
      };
}

class Sub3CategoryData {
  Sub3CategoryData({
    this.sub3CategoryId,
    this.categoryName,
    this.categoryId,
    this.subCategoryName,
    this.subCategoryId,
    this.sub3CategoryName,
    this.sub3CategoryImage,
  });

  String? sub3CategoryId;
  String? categoryName;
  String? categoryId;
  String? subCategoryName;
  String? subCategoryId;
  String? sub3CategoryName;
  String? sub3CategoryImage;

  factory Sub3CategoryData.fromJson(Map<String, dynamic> json) =>
      Sub3CategoryData(
        sub3CategoryId: json["sub3_category_id"],
        categoryName: json["categoryName"],
        categoryId: json["categoryId"],
        subCategoryName: json["subCategoryName"],
        subCategoryId: json["subCategoryId"],
        sub3CategoryName: json["sub3CategoryName"],
        sub3CategoryImage: json["sub3CategoryImage"],
      );

  Map<String, dynamic> toJson() => {
        "sub3_category_id": sub3CategoryId,
        "categoryName": categoryName,
        "categoryId": categoryId,
        "subCategoryName": subCategoryName,
        "subCategoryId": subCategoryId,
        "sub3CategoryName": sub3CategoryName,
        "sub3CategoryImage": sub3CategoryImage,
      };
}
