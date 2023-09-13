
import 'dart:convert';

BankAccountListModel bankPaymentMethodListModelFromJson(String str) =>
    BankAccountListModel.fromJson(json.decode(str));

String bankPaymentMethodListModelToJson(BankAccountListModel data) =>
    json.encode(data.toJson());

class BankAccountListModel {
  bool status;
  String message;
  List<MyBankAccountData> data;

  BankAccountListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BankAccountListModel.fromJson(Map<String, dynamic> json) =>
      BankAccountListModel(
        status: json["status"],
        message: json["message"],
        data: List<MyBankAccountData>.from(json["data"].map((x) => MyBankAccountData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MyBankAccountData {
  int id;
  dynamic bankId;
  String bankName;
  String accHolderName;
  String accNumber;
  String branchName;
  String routingNumber;
  String createdAt;

  MyBankAccountData({
    required this.id,
    required this.bankId,
    required this.bankName,
    required this.accHolderName,
    required this.accNumber,
    required this.branchName,
    required this.routingNumber,
    required this.createdAt,
  });

  factory MyBankAccountData.fromJson(Map<String, dynamic> json) => MyBankAccountData(
        id: json["id"],
        bankId: json["bank_id"],
        bankName: json["bank_name"],
        accHolderName: json["acc_holder_name"],
        accNumber: json["acc_number"],
        branchName: json["branch_name"],
        routingNumber: json["routing_number"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bank_id": bankId,
        "bank_name": bankName,
        "acc_holder_name": accHolderName,
        "acc_number": accNumber,
        "branch_name": branchName,
        "routing_number": routingNumber,
        "created_at": createdAt,
      };
}
