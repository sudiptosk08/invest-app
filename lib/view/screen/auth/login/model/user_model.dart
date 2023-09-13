// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool status;
  String message;
  Data data;

  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  User user;
  String token;

  Data({
    required this.user,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class User {
  String name;
  String userId;
  int balance;
  int totalEarning;
  String role;
  String countryCode;
  String phoneCode;
  String phone;
  String qrCode;
  String inviteLink;
  String createdAt;

  User({
    required this.name,
    required this.userId,
    required this.balance,
    required this.totalEarning,
    required this.role,
    required this.countryCode,
    required this.phoneCode,
    required this.phone,
    required this.qrCode,
    required this.inviteLink,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        userId: json["user_id"],
        balance: json["balance"],
        totalEarning: json["total_earning"],
        role: json["role"],
        countryCode: json["country_code"],
        phoneCode: json["phone_code"],
        phone: json["phone"],
        qrCode: json["qr_code"],
        inviteLink: json["invite_link"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "user_id": userId,
        "balance": balance,
        "total_earning": totalEarning,
        "role": role,
        "country_code": countryCode,
        "phone_code": phoneCode,
        "phone": phone,
        "qr_code": qrCode,
        "invite_link": inviteLink,
        "created_at": createdAt,
      };
}
