// To parse this JSON data, do
//
//     final variantProductsResponse = variantProductsResponseFromJson(jsonString);

import 'dart:convert';

VariantProductsResponse variantProductsResponseFromJson(String str) =>
    VariantProductsResponse.fromJson(json.decode(str));

String variantProductsResponseToJson(VariantProductsResponse data) =>
    json.encode(data.toJson());

class VariantProductsResponse {
  VariantProductsResponse({
    this.status,
    this.message,
    this.variantProducts,
  });

  bool? status;
  String? message;
  List<VariantProductData>? variantProducts;

  factory VariantProductsResponse.fromJson(Map<String, dynamic> json) =>
      VariantProductsResponse(
        status: json["status"],
        message: json["message"],
        variantProducts: List<VariantProductData>.from(
          json["variantProducts"].map(
            (x) => VariantProductData.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "variantProducts":
            List<dynamic>.from(variantProducts?.map((x) => x.toJson()) ?? []),
      };
}

class VariantProductData {
  VariantProductData({
    this.pId,
    this.productName,
    this.vpId,
    this.variantName,
    this.productMrp,
    this.productSp,
    this.pGst,
    this.discount,
    this.productMoq,
    this.qty,
  });

  String? pId;
  String? productName;
  String? vpId;
  String? variantName;
  String? productMrp;
  String? productSp;
  String? pGst;
  String? discount;
  String? productMoq;
  int? qty = 0;

  factory VariantProductData.fromJson(Map<String, dynamic> json) =>
      VariantProductData(
        pId: json["pId"],
        productName: json["productName"],
        vpId: json["vpId"],
        variantName: json["variantName"],
        productMrp: json["productMrp"],
        productSp: json["productSp"],
        pGst: json["pGst"],
        discount: json["discount"],
        productMoq: json["productMoq"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "pId": pId,
        "productName": productName,
        "vpId": vpId,
        "variantName": variantName,
        "productMrp": productMrp,
        "productSp": productSp,
        "pGst": pGst,
        "discount": discount,
        "productMoq": productMoq,
        "qty": qty,
      };
}
