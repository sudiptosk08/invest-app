import 'dart:convert';

UpdateUserModel updateUserModelFromJson(String str) =>
    UpdateUserModel.fromJson(json.decode(str));

String updateUserModelToJson(UpdateUserModel data) =>
    json.encode(data.toJson());

class UpdateUserModel {
  bool status;
  String message;
  Data data;

  UpdateUserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserModel(
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
  String name;
  String userId;
  int balance;
  int totalEarning;
  String role;
  String countryCode;
  String phone;
  String qrCode;
  String inviteLink;
  String createdAt;

  Data({
    required this.name,
    required this.userId,
    required this.balance,
    required this.totalEarning,
    required this.role,
    required this.countryCode,
    required this.phone,
    required this.qrCode,
    required this.inviteLink,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        userId: json["user_id"],
        balance: json["balance"],
        totalEarning: json["total_earning"],
        role: json["role"],
        countryCode: json["country_code"],
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
        "phone": phone,
        "qr_code": qrCode,
        "invite_link": inviteLink,
        "created_at": createdAt,
      };
}
