class VariantProducts {
  int? id;
  String? name;
  int? qty = 0;
  int? availableStock = 0;
  String? minQty;
  String? price;
  String? stock;

  VariantProducts({
    required this.id,
    required this.name,
    required this.qty,
    required this.minQty,
    required this.price,
    required this.stock,
    required this.availableStock,
  });

  Map<String, dynamic> toJson() => {
        "id": id!,
        "name": name!,
        "qty": qty!,
        "minQty": minQty!,
        "price": price!,
        "stock": stock!,
        "availableStock": availableStock!,
      };
}

class RelatedProducts {
  String? id;
  String? name;
  int? qty = 0;
  String? minQty;
  String? price;
  String? stock;
  String? image;
  String? pCategory;

  RelatedProducts({
    required this.id,
    required this.name,
    required this.qty,
    required this.minQty,
    required this.price,
    required this.stock,
    required this.image,
    required this.pCategory,
  });

  Map<String, dynamic> toJson() => {
        "id": id!,
        "name": name!,
        "qty": qty!,
        "minQty": minQty!,
        "price": price!,
        "stock": stock!,
        "image": image!,
        "pCategory": pCategory!,
      };
}
