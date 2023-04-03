// To parse this JSON data, do
//
//     final mainCategoryResponse = mainCategoryResponseFromJson(jsonString);

import 'dart:convert';

MainCategoryResponse mainCategoryResponseFromJson(String str) => MainCategoryResponse.fromJson(json.decode(str));

String mainCategoryResponseToJson(MainCategoryResponse data) => json.encode(data.toJson());

class MainCategoryResponse {
  MainCategoryResponse({
    this.status,
    this.message,
    this.category,
  });

  bool? status;
  String? message;
  List<CategoryData>? category;

  factory MainCategoryResponse.fromJson(Map<String, dynamic> json) => MainCategoryResponse(
        status: json["status"],
        message: json["message"],
        category: List<CategoryData>.from(json["category"].map((x) => CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "category": List<dynamic>.from(category?.map((x) => x.toJson()) ?? []),
      };
}

class CategoryData {
  CategoryData({
    this.categoryId,
    this.categoryName,
    this.categoryImage,
  });

  String? categoryId;
  String? categoryName;
  String? categoryImage;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        categoryImage: json["categoryImage"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "categoryImage": categoryImage,
      };
}
