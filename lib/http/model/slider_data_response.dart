import 'dart:convert';

SliderDataResponse sliderDataResponseFromJson(String str) => SliderDataResponse.fromJson(json.decode(str));

String sliderDataResponseToJson(SliderDataResponse data) => json.encode(data.toJson());

class SliderDataResponse {
  SliderDataResponse({
    this.status,
    this.message,
    this.sliders,
  });

  bool? status;
  String? message;
  List<SliderData>? sliders;

  factory SliderDataResponse.fromJson(Map<String, dynamic> json) => SliderDataResponse(
    status: json["status"],
    message: json["message"],
    sliders: List<SliderData>.from(json["sliders"].map((x) => SliderData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "sliders": List<dynamic>.from(sliders?.map((x) => x.toJson()) ?? []),
  };
}

class SliderData {
  SliderData({
    this.categoryId,
    this.sliderImages,
    this.sliderLink,
  });

  int? categoryId;
  String? sliderImages;
  String? sliderLink;

  factory SliderData.fromJson(Map<String, dynamic> json) => SliderData(
    categoryId: json["category_id"],
    sliderImages: json["slider_images"],
    sliderLink: json["slider_link"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "slider_images": sliderImages,
    "slider_link": sliderLink,
  };
}
