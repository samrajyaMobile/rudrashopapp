// To parse this JSON data, do
//
//     final subCategoryResponse = subCategoryResponseFromJson(jsonString);

import 'dart:convert';

SubCategoryResponse subCategoryResponseFromJson(String str) => SubCategoryResponse.fromJson(json.decode(str));

String subCategoryResponseToJson(SubCategoryResponse data) => json.encode(data.toJson());

class SubCategoryResponse {
  SubCategoryResponse({
    this.status,
    this.message,
    this.subCategory,
  });

  bool? status;
  String? message;
  List<SubCategoryData>? subCategory;

  factory SubCategoryResponse.fromJson(Map<String, dynamic> json) => SubCategoryResponse(
    status: json["status"],
    message: json["message"],
    subCategory: List<SubCategoryData>.from(json["subCategory"].map((x) => SubCategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "subCategory": List<dynamic>.from(subCategory?.map((x) => x.toJson()) ?? []),
  };
}

class SubCategoryData {
  SubCategoryData({
    this.subCategoryId,
    this.categoryName,
    this.categoryId,
    this.subCategoryName,
    this.subCategoryImage,
  });

  String? subCategoryId;
  String? categoryName;
  String? categoryId;
  String? subCategoryName;
  String? subCategoryImage;

  factory SubCategoryData.fromJson(Map<String, dynamic> json) => SubCategoryData(
    subCategoryId: json["sub_category_id"],
    categoryName: json["categoryName"],
    categoryId: json["categoryId"],
    subCategoryName: json["subCategoryName"],
    subCategoryImage: json["subCategoryImage"],
  );

  Map<String, dynamic> toJson() => {
    "sub_category_id": subCategoryId,
    "categoryName": categoryName,
    "categoryId": categoryId,
    "subCategoryName": subCategoryName,
    "subCategoryImage": subCategoryImage,
  };
}
