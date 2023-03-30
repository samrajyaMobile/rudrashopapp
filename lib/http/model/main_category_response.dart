import 'dart:convert';

MainCategoryResponse mainCategoryResponseFromJson(String str) => MainCategoryResponse.fromJson(json.decode(str));

String mainCategoryResponseToJson(MainCategoryResponse data) => json.encode(data.toJson());

class MainCategoryResponse {
  MainCategoryResponse({
    this.status,
    this.message,
    this.categories,
  });

  bool? status;
  String? message;
  List<CategoryData>? categories;

  factory MainCategoryResponse.fromJson(Map<String, dynamic> json) => MainCategoryResponse(
        status: json["status"],
        message: json["message"],
        categories: List<CategoryData>.from(json["categories"].map((x) => CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "categories": List<dynamic>.from(categories?.map((x) => x.toJson()) ?? []),
      };
}

class CategoryData {
  CategoryData({
    this.categorySid,
    this.categoryName,
    this.categoryImage,
  });

  String? categorySid;
  String? categoryName;
  String? categoryImage;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        categorySid: json["category_sid"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
      );

  Map<String, dynamic> toJson() => {
        "category_sid": categorySid,
        "category_name": categoryName,
        "category_image": categoryImage,
      };
}
