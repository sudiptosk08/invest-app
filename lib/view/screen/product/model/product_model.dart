// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  List<Datum> data;
  bool status;
  String message;

  ProductModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Datum {
  int id;
  String name;
  String image;
  int price;
  dynamic dailyIncome;
  dynamic minWithdraw;
  int validity;
  dynamic totalEarning;
  String description;

  Datum({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.dailyIncome,
    required this.minWithdraw,
    required this.validity,
    required this.totalEarning,
    required this.description,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        dailyIncome: json["daily_income"],
        minWithdraw: json["min_withdraw"],
        validity: json["validity"],
        totalEarning: json["total_earning"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "daily_income": dailyIncome,
        "min_withdraw": minWithdraw,
        "validity": validity,
        "total_earning": totalEarning,
        "description": description,
      };
}
