// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.status,
    this.message,
    this.user,
  });

  bool? status;
  String? message;
  List<User>? user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        message: json["message"],
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": List<dynamic>.from(user?.map((x) => x.toJson()) ?? []),
      };
}

class User {
  User({
    this.uEmail,
    this.uName,
    this.uSurname,
    this.uMoNumber,
    this.uBusinessName,
    this.uAddress,
    this.uCity,
    this.uPincode,
  });

  String? uEmail;
  String? uName;
  String? uSurname;
  int? uMoNumber;
  String? uBusinessName;
  String? uAddress;
  String? uCity;
  int? uPincode;

  factory User.fromJson(Map<String, dynamic> json) => User(
        uEmail: json["u_email"],
        uName: json["u_name"],
        uSurname: json["u_surname"],
        uMoNumber: json["u_mo_number"],
        uBusinessName: json["u_business_name"],
        uAddress: json["u_address"],
        uCity: json["u_city"],
        uPincode: json["u_pincode"],
      );

  Map<String, dynamic> toJson() => {
        "u_email": uEmail,
        "u_name": uName,
        "u_surname": uSurname,
        "u_mo_number": uMoNumber,
        "u_business_name": uBusinessName,
        "u_address": uAddress,
        "u_city": uCity,
        "u_pincode": uPincode,
      };
}
