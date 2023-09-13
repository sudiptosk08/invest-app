// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  bool status;
  String message;
  List<BannerDatum> data;

  BannerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        status: json["status"],
        message: json["message"],
        data: List<BannerDatum>.from(json["data"].map((x) => BannerDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BannerDatum {
  String title;
  String image;

  BannerDatum({
    required this.title,
    required this.image,
  });

  factory BannerDatum.fromJson(Map<String, dynamic> json) => BannerDatum(
        title: json["title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
      };
}
