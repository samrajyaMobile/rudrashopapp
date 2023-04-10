// To parse this JSON data, do
//
//     final bannersResponse = bannersResponseFromJson(jsonString);

import 'dart:convert';

BannersResponse bannersResponseFromJson(String str) => BannersResponse.fromJson(json.decode(str));

String bannersResponseToJson(BannersResponse data) => json.encode(data.toJson());

class BannersResponse {
  BannersResponse({
    this.status,
    this.message,
    this.banners,
  });

  bool? status;
  String? message;
  List<BannerData>? banners;

  factory BannersResponse.fromJson(Map<String, dynamic> json) => BannersResponse(
        status: json["status"],
        message: json["message"],
        banners: List<BannerData>.from(json["banners"].map((x) => BannerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "banners": List<dynamic>.from(banners?.map((x) => x.toJson()) ?? []),
      };
}

class BannerData {
  BannerData({
    this.bannerId,
    this.bannerImages,
  });

  String? bannerId;
  String? bannerImages;

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        bannerId: json["bannerId"],
        bannerImages: json["bannerImages"],
      );

  Map<String, dynamic> toJson() => {
        "bannerId": bannerId,
        "bannerImages": bannerImages,
      };
}
