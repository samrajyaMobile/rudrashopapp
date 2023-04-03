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
    this.categoryId,
    this.categoryName,
    this.subCategoryId,
    this.subCategoryName,
    this.subCategoryImage,
  });

  String? categoryId;
  String? categoryName;
  String? subCategoryId;
  String? subCategoryName;
  String? subCategoryImage;

  factory SubCategoryData.fromJson(Map<String, dynamic> json) => SubCategoryData(
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    subCategoryId: json["subCategoryId"],
    subCategoryName: json["subCategoryName"],
    subCategoryImage: json["subCategoryImage"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "subCategoryId": subCategoryId,
    "subCategoryName": subCategoryName,
    "subCategoryImage": subCategoryImage,
  };
}
