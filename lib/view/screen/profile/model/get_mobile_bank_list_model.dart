// To parse this JSON data, do
//
//     final getMobileBankListModel = getMobileBankListModelFromJson(jsonString);

import 'dart:convert';

GetMobileBankListModel getMobileBankListModelFromJson(String str) =>
    GetMobileBankListModel.fromJson(json.decode(str));

String getMobileBankListModelToJson(GetMobileBankListModel data) =>
    json.encode(data.toJson());

class GetMobileBankListModel {
  bool status;
  String message;
  List<MobileBankDatum> data;

  GetMobileBankListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetMobileBankListModel.fromJson(Map<String, dynamic> json) =>
      GetMobileBankListModel(
        status: json["status"],
        message: json["message"],
        data: List<MobileBankDatum>.from(json["data"].map((x) => MobileBankDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MobileBankDatum {
  int id;
  String name;

  MobileBankDatum({
    required this.id,
    required this.name,
  });

  factory MobileBankDatum.fromJson(Map<String, dynamic> json) => MobileBankDatum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
