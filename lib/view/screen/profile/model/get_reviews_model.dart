// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

ReviewModel reviewModelFromJson(String str) =>
    ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  bool status;
  String message;
  List<RiviewsDatum> data;

  ReviewModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        status: json["status"],
        message: json["message"],
        data: List<RiviewsDatum>.from(json["data"].map((x) => RiviewsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RiviewsDatum {
  String user;
  String userId;
  String msg;
  String image;

  RiviewsDatum({
    required this.user,
    required this.userId,
    required this.msg,
    required this.image,
  });

  factory RiviewsDatum.fromJson(Map<String, dynamic> json) => RiviewsDatum(
        user: json["user"],
        userId: json["user_id"],
        msg: json["msg"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "user_id": userId,
        "msg": msg,
        "image": image,
      };
}



