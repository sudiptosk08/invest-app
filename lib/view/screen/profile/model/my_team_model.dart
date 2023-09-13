// To parse this JSON data, do
//
//     final myTeamModel = myTeamModelFromJson(jsonString);

import 'dart:convert';

MyTeamModel myTeamModelFromJson(String str) =>
    MyTeamModel.fromJson(json.decode(str));

String myTeamModelToJson(MyTeamModel data) => json.encode(data.toJson());

class MyTeamModel {
  bool status;
  String message;
  MyTeamData data;

  MyTeamModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MyTeamModel.fromJson(Map<String, dynamic> json) => MyTeamModel(
        status: json["status"],
        message: json["message"],
        data: MyTeamData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class MyTeamData {
  String instructions;
  List<Tier1> tier1;
  List<Tier2> tier2;
  List<Tier3> tier3;
  TeamData teamData;
  
  MyTeamData({
    required this.instructions,
    required this.tier1,
    required this.tier2,
    required this.tier3,
    required this.teamData,
  });

  factory MyTeamData.fromJson(Map<String, dynamic> json) => MyTeamData(
        instructions: json["instructions"],
        tier1: List<Tier1>.from(json["tier1"].map((x) => Tier1.fromJson(x))),
        tier2: List<Tier2>.from(json["tier2"].map((x) => Tier2.fromJson(x))),
        tier3: List<Tier3>.from(json["tier3"].map((x) => Tier3.fromJson(x))),
        teamData: TeamData.fromJson(json["teamData"]),
      );

  Map<String, dynamic> toJson() => {
        "instructions": instructions,
        "tier1": List<dynamic>.from(tier1.map((x) => x.toJson())),
        "tier2": List<dynamic>.from(tier2.map((x) => x.toJson())),
        "tier3": List<dynamic>.from(tier3.map((x) => x.toJson())),
        "teamData": teamData.toJson(),
      };
}

class Tier1 {
  String userId;
  String name;
  String createdAt;

  Tier1({
    required this.userId,
    required this.name,
    required this.createdAt,
  });

  factory Tier1.fromJson(Map<String, dynamic> json) => Tier1(
        userId: json["user_id"],
        name: json["name"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "created_at": createdAt,
      };
}

class Tier2 {
  String userId;
  String name;
  String createdAt;

  Tier2({
    required this.userId,
    required this.name,
    required this.createdAt,
  });

  factory Tier2.fromJson(Map<String, dynamic> json) => Tier2(
        userId: json["user_id"],
        name: json["name"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "created_at": createdAt,
      };
}

class Tier3 {
  String userId;
  String name;
  String createdAt;

  Tier3({
    required this.userId,
    required this.name,
    required this.createdAt,
  });

  factory Tier3.fromJson(Map<String, dynamic> json) => Tier3(
        userId: json["user_id"],
        name: json["name"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "created_at": createdAt,
      };
}

class TeamData {
  int size;
  int investments;
  int recharges;
  int withdraws;
  int usdtRecharges;
  int usdtWithdraws;
  int investmentsCount;
  int registrationBonus;

  TeamData({
    required this.size,
    required this.investments,
    required this.recharges,
    required this.withdraws,
    required this.usdtRecharges,
    required this.usdtWithdraws,
    required this.investmentsCount,
    required this.registrationBonus,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) => TeamData(
        size: json["size"],
        investments: json["investments"],
        recharges: json["recharges"],
        withdraws: json["withdraws"],
        usdtRecharges: json["usdt_recharges"],
        usdtWithdraws: json["usdt_withdraws"],
        investmentsCount: json["investments_count"],
        registrationBonus: json["registration_bonus"],
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        "investments": investments,
        "recharges": recharges,
        "withdraws": withdraws,
        "usdt_recharges": usdtRecharges,
        "usdt_withdraws": usdtWithdraws,
        "investments_count": investmentsCount,
        "registration_bonus": registrationBonus,
      };
}
