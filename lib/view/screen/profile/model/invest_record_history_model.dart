// To parse this JSON data, do
//
//     final investRecordHistoryModel = investRecordHistoryModelFromJson(jsonString);

import 'dart:convert';

InvestRecordHistoryModel investRecordHistoryModelFromJson(String str) =>
    InvestRecordHistoryModel.fromJson(json.decode(str));

String investRecordHistoryModelToJson(InvestRecordHistoryModel data) =>
    json.encode(data.toJson());

class InvestRecordHistoryModel {
  List<Datum> data;
  bool status;
  String message;

  InvestRecordHistoryModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory InvestRecordHistoryModel.fromJson(Map<String, dynamic> json) =>
      InvestRecordHistoryModel(
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
  dynamic price;
  dynamic totalEarned;
  dynamic validity;
  dynamic remainingDays;
  dynamic createdAt;
  Product product;

  Datum({
    required this.price,
    required this.totalEarned,
    required this.validity,
    required this.remainingDays,
    required this.createdAt,
    required this.product,
  });

  factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        price: json["price"],
        totalEarned: json["total_earned"],
        validity: json["validity"],
        remainingDays: json["remaining_days"],
        createdAt: json["created_at"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "total_earned": totalEarned,
        "validity": validity,
        "remaining_days": remainingDays,
        "created_at": createdAt,
        "product": product.toJson(),
      };
}

class Product {
  int id;
  String name;
  String image;
  int price;
  dynamic dailyIncome;
  dynamic minWithdraw;
  int validity;
  dynamic totalEarning;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.dailyIncome,
    required this.minWithdraw,
    required this.validity,
    required this.totalEarning,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        dailyIncome: json["daily_income"],
        minWithdraw: json["min_withdraw"],
        validity: json["validity"],
        totalEarning: json["total_earning"] ,
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
      };
}
