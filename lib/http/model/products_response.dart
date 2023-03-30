import 'dart:convert';

ProductsResponse productsResponseFromJson(String str) => ProductsResponse.fromJson(json.decode(str));

String productsResponseToJson(ProductsResponse data) => json.encode(data.toJson());

class ProductsResponse {
  ProductsResponse({
    this.status,
    this.message,
    this.products,
  });

  bool? status;
  String? message;
  List<ProductData>? products;

  factory ProductsResponse.fromJson(Map<String, dynamic> json) => ProductsResponse(
    status: json["status"],
    message: json["message"],
    products: List<ProductData>.from(json["products"].map((x) => ProductData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "products": List<dynamic>.from(products?.map((x) => x.toJson()) ?? []),
  };
}

class ProductData {
  ProductData({
    this.productId,
    this.commanName,
    this.categoryName,
    this.categoryId,
    this.productName,
    this.productImage,
    this.productPrice,
    this.ourPrice,
    this.discount,
    this.description,
  });

  String? productId;
  String? commanName;
  String? categoryName;
  int? categoryId;
  String? productName;
  String? productImage;
  int? productPrice;
  int? ourPrice;
  int? discount;
  String? description;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    productId: json["productID"],
    commanName: json["commanName"],
    categoryName: json["categoryName"],
    categoryId: json["categoryId"],
    productName: json["productName"],
    productImage: json["productImage"],
    productPrice: json["productPrice"],
    ourPrice: json["ourPrice"],
    discount: json["discount"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "productID": productId,
    "commanName": commanName,
    "categoryName": categoryName,
    "categoryId": categoryId,
    "productName": productName,
    "productImage": productImage,
    "productPrice": productPrice,
    "ourPrice": ourPrice,
    "discount": discount,
    "description": description,
  };
}
