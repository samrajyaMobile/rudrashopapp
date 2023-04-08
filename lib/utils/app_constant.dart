// ignore_for_file: constant_identifier_names
import 'package:google_sign_in/google_sign_in.dart';

class AppConstant {
  static const String GET_SLIDERS =
      "https://script.google.com/macros/s/AKfycbwzH-VFdTr6fnT2NAMilTqmTpzvAU1oS5bf34wwcDw9YjD2rrBWQKwSsRQK_TSicqTgYg/exec";
  static const String GET_PRODUCTS =
      "https://script.google.com/macros/s/AKfycbx3IkWNj74AhJX4Nfgr1n97fNHiRgGa-YdbuzLOot3ZLk-KRhsvxvYpL__IMRKxMDzZ/exec";

  static const String GET_LOGIN =
      "https://script.google.com/macros/s/AKfycby1cI7i25CsVF35-lj2K0-wQiKc5K9JHJ9S5oLdSdawa_XsnXeDxJYILP8DIkQgjtwO/exec?action=login";
  static const String SIGNUP =
      "https://script.google.com/macros/s/AKfycbzmkaPojN8_JrJaoAnD29bqR2u8BCwgKAToe8d2_N1GlXeUGhhZph-fbaZcqObeqKEc/exec?action=register";

  /// Categories
  static const String GET_CATEGORIES =
      "https://script.google.com/macros/s/AKfycbx22STA4i8cvzmkQZUWlpDBWK4S0DLB0oDIDNrTjpm-Kyhwug-KxYEn02RPnAZrlBssbg/exec";
  static const String GET_SUB_CATEGORIES =
      "https://script.google.com/macros/s/AKfycbwgCZ0nkASzpYX0OhMTt4hgNxUEve5HgQbBfTbmacl3ddFax7tFaNnXLrZ_2Wo8zpsJ/exec?";
  static const String GET_SUB3_CATEGORIES =
      "https://script.google.com/macros/s/AKfycbybyxwUihPayqekC_bcqTtmAKQb4vZCXjCDkNR-GS2_rsrgja9bIgY5f8cZq_LDPmhf/exec?";

  /// Products
  static const String GET_MAIN_PRODUCTS =
      "https://script.google.com/macros/s/AKfycbyU-piYHrtxarF0fzsXLQSyKAbZFQawfPgIumtqbO0LDDVmJ5KuaWjKp4tXVXkU7PT3/exec?";
  static const String GET_DEAL_OF_THE_DAY =
      "https://script.google.com/macros/s/AKfycbxv_5k54Dd9e71JRpvu-9MCZpIHoXLnyUW_1Iz77c_Gx7TYAlYMyhdqC6PnMqF_Qar7/exec";
  static const String GET_NEW_ARRIVALS =
      "https://script.google.com/macros/s/AKfycbxk7q1Wh0Uyi8kCPwcZb4mk912XlKNpvb47HqGspcECBW-787WszJe6HehJHd9ceVVb/exec";
  static const String GET_CLEARANCE =
      "https://script.google.com/macros/s/AKfycbzSbwFnjXUQV7ORz1UCnoXtU3rh7Bk5JEbMue-badcdnIZW_VDXp2qDWzPYTksl5MzN/exec";

  /// Variant Products
  static const String GET_VARIANT_OF_PRODUCTS =
      "https://script.google.com/macros/s/AKfycbzHp7tPCHOhzw31DRqbDaKQ7hEQdiNcv0f41bUzfPGIhfZtYuhVPalRbMqzRLFsHT_R/exec";
}

class QueryParamsConstant {
  static const CATEGORY_ID = "categoryId";
  static const SUB_CATEGORY_ID = "subCategoryId";
  static const SUB_3_CATEGORY_ID = "sub3CategoryId";
}

class SharedPrefConstant {
  static const U_NAME = "u_name";
  static const U_SURNAME = "u_surname";
  static const U_EMAIL = "u_email";
  static const U_MO_NUMBER = "u_mo_number";
  static const U_BUSINESS_NAME = "u_business";
  static const U_ADDRESS = "u_address";
  static const U_CITY = "u_city";
  static const U_PIN = "u_pin";
}
