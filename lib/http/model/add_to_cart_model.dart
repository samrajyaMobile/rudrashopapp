class AddToCartModel {
  String? productImage;
  String? productName;
  String? productModel;
  String? productQty;
  String? total;

  AddToCartModel({
    required this.productImage,
    required this.productName,
    required this.productModel,
    required this.productQty,
    required this.total,
  });

  Map<String, String> toJson() => {
        "productsImage": productImage!,
        "productsName": productName!,
        "productsModel": productModel!,
        "productsQty": productQty!,
        "total": total!,
      };

  factory AddToCartModel.fromJson(Map<String, dynamic> json) => AddToCartModel(
        productImage: json["productsImage"],
        productName: json["productsName"],
        productModel: json["productsModel"],
        productQty: json["productsQty"],
        total: json["total"],
      );
}
