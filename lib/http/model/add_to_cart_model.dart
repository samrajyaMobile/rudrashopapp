class AddToCartModel {
  int? id;
  int? productQty;

  AddToCartModel({
    required this.id,
    required this.productQty,
  });

  Map<String, dynamic> toJson() => {
        "id": id!,
        "productQty": productQty!,
      };

  factory AddToCartModel.fromJson(Map<String, dynamic> json) => AddToCartModel(
        id: json["id"],
        productQty: json["productsQty"],
      );
}
