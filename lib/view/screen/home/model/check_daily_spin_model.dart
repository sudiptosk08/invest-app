// To parse this JSON data, do
//
//     final dailySpinCheckModel = dailySpinCheckModelFromJson(jsonString);

import 'dart:convert';

DailySpinCheckModel dailySpinCheckModelFromJson(String str) => DailySpinCheckModel.fromJson(json.decode(str));

String dailySpinCheckModelToJson(DailySpinCheckModel data) => json.encode(data.toJson());

class DailySpinCheckModel {
    bool status;
    String message;
    CheckSpinData data;

    DailySpinCheckModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory DailySpinCheckModel.fromJson(Map<String, dynamic> json) => DailySpinCheckModel(
        status: json["status"],
        message: json["message"],
        data: CheckSpinData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class CheckSpinData {
    bool canSpin;

    CheckSpinData({
        required this.canSpin,
    });

    factory CheckSpinData.fromJson(Map<String, dynamic> json) => CheckSpinData(
        canSpin: json["can_spin"],
    );

    Map<String, dynamic> toJson() => {
        "can_spin": canSpin,
    };
}
