// To parse this JSON data, do
//
//     final versionCodeResponse = versionCodeResponseFromJson(jsonString);

import 'dart:convert';

VersionCodeResponse versionCodeResponseFromJson(String str) => VersionCodeResponse.fromJson(json.decode(str));

String versionCodeResponseToJson(VersionCodeResponse data) => json.encode(data.toJson());

class VersionCodeResponse {
  List<Datum>? data;

  VersionCodeResponse({
    this.data,
  });

  factory VersionCodeResponse.fromJson(Map<String, dynamic> json) => VersionCodeResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
      };
}

class Datum {
  int? id;
  String? android;
  String? ios;
  String? appstoreurl;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? publishedAt;

  Datum({
    this.id,
    this.android,
    this.ios,
    this.appstoreurl,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        android: json["android"],
        ios: json["ios"],
        appstoreurl: json["appstoreurl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "android": android,
        "ios": ios,
        "appstoreurl": appstoreurl,
        "createdAt": createdAt.toString(),
        "updatedAt": updatedAt.toString(),
        "publishedAt": publishedAt.toString(),
      };
}
