import 'dart:convert';

GetBankListModel getBankListModelFromJson(String str) =>
    GetBankListModel.fromJson(json.decode(str));

String getBankListModelToJson(GetBankListModel data) =>
    json.encode(data.toJson());

class GetBankListModel {
  bool status;
  String message;
  List<BankListDatum> data;

  GetBankListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetBankListModel.fromJson(Map<String, dynamic> json) =>
      GetBankListModel(
        status: json["status"],
        message: json["message"],
        data: List<BankListDatum>.from(json["data"].map((x) => BankListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BankListDatum {
  int id;
  String name;

  BankListDatum({
    required this.id,
    required this.name,
  });

  factory BankListDatum.fromJson(Map<String, dynamic> json) => BankListDatum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
