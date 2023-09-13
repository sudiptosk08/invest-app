

import 'dart:convert';

SpinSettingModel spinSettingModelFromJson(String str) =>
    SpinSettingModel.fromJson(json.decode(str));

String spinSettingModelToJson(SpinSettingModel data) =>
    json.encode(data.toJson());

class SpinSettingModel {
  bool status;
  String message;
  SpinSettingData data;

  SpinSettingModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SpinSettingModel.fromJson(Map<String, dynamic> json) =>
      SpinSettingModel(
        status: json["status"],
        message: json["message"],
        data: SpinSettingData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class SpinSettingData {
  String unit;
  List<String> amounts;

  SpinSettingData({
    required this.unit,
    required this.amounts,
  });

  factory SpinSettingData.fromJson(Map<String, dynamic> json) => SpinSettingData(
        unit: json["unit"],
        amounts: List<String>.from(json["amounts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "unit": unit,
        "amounts": List<dynamic>.from(amounts.map((x) => x)),
      };
}
