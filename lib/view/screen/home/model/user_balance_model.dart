
import 'dart:convert';

UserBalanceModel userBalanceModelFromJson(String str) => UserBalanceModel.fromJson(json.decode(str));

String userBalanceModelToJson(UserBalanceModel data) => json.encode(data.toJson());

class UserBalanceModel {
    bool status;
    String message;
    BalanceData data;

    UserBalanceModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory UserBalanceModel.fromJson(Map<String, dynamic> json) => UserBalanceModel(
        status: json["status"],
        message: json["message"],
        data: BalanceData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class BalanceData {
  int balance;
  int totalEarning;

  BalanceData({
    required this.balance,
    required this.totalEarning,
  });

  factory BalanceData.fromJson(Map<String, dynamic> json) => BalanceData(
        balance: json["balance"],
        totalEarning: json["total_earning"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "total_earning": totalEarning,
      };
}
