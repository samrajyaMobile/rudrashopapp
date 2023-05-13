import 'dart:convert';

class AddToCartModel {
  int? id;
  int? productQty;
  String? image;
  int? qty;
  String? name;
  String? pCategory;
  double? price;

  AddToCartModel({
    required this.id,
    required this.productQty,
    required this.image,
    required this.qty,
    required this.name,
    required this.pCategory,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
        "id": id!,
        "productQty": productQty!,
        "image": image!,
        "qty": qty!,
        "name": name!,
        "pCategory": pCategory!,
        "price": price!,
      };

  factory AddToCartModel.fromJson(Map<String, dynamic> json) => AddToCartModel(
        id: json["id"],
        productQty: json["productQty"],
        image: json["image"],
        qty: json["qty"],
        name: json["name"],
        pCategory: json["pCategory"],
        price: json["price"],
      );
}
