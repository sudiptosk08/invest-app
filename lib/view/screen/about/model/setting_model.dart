// To parse this JSON Settingdata, do
//
//     final settingModel = settingModelFromJson(jsonString);

import 'dart:convert';

SettingModel settingModelFromJson(String str) =>
    SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
  bool status;
  String message;
  SettingData data;

  SettingModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
        status: json["status"],
        message: json["message"],
        data: SettingData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class SettingData {
  String appName;
  String appIcon;
  List<String> aboutImages;
  String email;
  String whatsappLink;
  String telegramLink;
  dynamic minimumWithdraw;
  String country;
  String phone;
  String currency;
  String address;
  String about;
  String inviteInstructions;
  String referalInstructions;
  List<String> allowedCountries;

  SettingData({
    required this.appName,
    required this.appIcon,
    required this.aboutImages,
    required this.email,
    required this.whatsappLink,
    required this.telegramLink,
    required this.minimumWithdraw,
    required this.phone,
    required this.country,
    required this.currency,
    required this.address,
    required this.about,
    required this.inviteInstructions,
    required this.referalInstructions,
    required this.allowedCountries,
  });

  factory SettingData.fromJson(Map<String, dynamic> json) => SettingData(
        appName: json["app_name"],
        appIcon: json["app_icon"],
        aboutImages: List<String>.from(json["about_images"].map((x) => x)),
        email: json["email"],
        whatsappLink: json["whatsapp_link"],
        telegramLink: json["telegram_link"],
        minimumWithdraw: json["minimum_withdraw"],
        phone: json["phone"],
        country: json["country"],
        currency: json["currency"],
        address: json["address"],
        about: json["about"],
        inviteInstructions: json["invite_instructions"],
        referalInstructions: json["referal_instructions"],
        allowedCountries:
            List<String>.from(json["allowed_countries"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "app_name": appName,
        "app_icon": appIcon,
        "about_images": List<dynamic>.from(aboutImages.map((x) => x)),
        "email": email,
        "whatsapp_link": whatsappLink,
        "telegram_link": telegramLink,
        "minimum_withdraw": minimumWithdraw,
        "phone": phone,
        "country": country,
        "currency": currency,
        "address": address,
        "about": about,
        "invite_instructions": inviteInstructions,
        "referal_instructions": referalInstructions,
        "allowed_countries": List<dynamic>.from(allowedCountries.map((x) => x)),
      };
}
