// To parse this JSON data, do
//
//     final mobileBankingListModel = mobileBankingListModelFromJson(jsonString);

import 'dart:convert';

MobileBankingListModel mobileBankingListModelFromJson(String str) =>
    MobileBankingListModel.fromJson(json.decode(str));

String mobileBankingListModelToJson(MobileBankingListModel data) =>
    json.encode(data.toJson());

class MobileBankingListModel {
  bool status;
  String message;
  List<MyMobileBankData> data;

  MobileBankingListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MobileBankingListModel.fromJson(Map<String, dynamic> json) =>
      MobileBankingListModel(
        status: json["status"],
        message: json["message"],
        data: List<MyMobileBankData>.from(json["data"].map((x) => MyMobileBankData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MyMobileBankData {
  int id;
  dynamic mobileBankId;
  String mobileBankName;
  String accNumber;
  String type;
  String createdAt;

  MyMobileBankData({
    required this.id,
    required this.mobileBankId,
    required this.mobileBankName,
    required this.accNumber,
    required this.type,
    required this.createdAt,
  });

  factory MyMobileBankData.fromJson(Map<String, dynamic> json) => MyMobileBankData(
        id: json["id"],
        mobileBankId: json["mobile_bank_id"],
        mobileBankName: json["mobile_bank_name"],
        accNumber: json["acc_number"],
        type: json["type"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mobile_bank_id": mobileBankId,
        "mobile_bank_name": mobileBankName,
        "acc_number": accNumber,
        "type": type,
        "created_at": createdAt,
      };
}
