// To parse this JSON data, do
//
//     final withdrawHistoryModel = withdrawHistoryModelFromJson(jsonString);

import 'dart:convert';

WithdrawHistoryModel withdrawHistoryModelFromJson(String str) =>
    WithdrawHistoryModel.fromJson(json.decode(str));

String withdrawHistoryModelToJson(WithdrawHistoryModel data) =>
    json.encode(data.toJson());

class WithdrawHistoryModel {
  List<WithdrawDatum> data;
  Links links;
  Meta meta;
  bool status;
  String message;

  WithdrawHistoryModel({
    required this.data,
    required this.links,
    required this.meta,
    required this.status,
    required this.message,
  });

  factory WithdrawHistoryModel.fromJson(Map<String, dynamic> json) =>
      WithdrawHistoryModel(
        data: List<WithdrawDatum>.from(json["data"].map((x) => WithdrawDatum.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
        "status": status,
        "message": message,
      };
}

class WithdrawDatum {
  int id;
  int amount;
  String status;
  String rejectReason;
  String createdAt;
  dynamic bankAccountId;
  BankAccount? bankAccount;
  dynamic mobileBankAccountId;
  MobileBankAccount? mobileBankAccount;

  WithdrawDatum({
    required this.id,
    required this.amount,
    required this.status,
    required this.rejectReason,
    required this.createdAt,
    required this.bankAccountId,
    this.bankAccount,
    required this.mobileBankAccountId,
    this.mobileBankAccount,
  });

  factory WithdrawDatum.fromJson(Map<String, dynamic> json) => WithdrawDatum(
        id: json["id"],
        amount: json["amount"],
        status: json["status"],
        rejectReason: json["reject_reason"],
        createdAt: json["created_at"],
        bankAccountId: json["bank_account_id"],
        bankAccount: json["bank_account"] == null
            ? null
            : BankAccount.fromJson(json["bank_account"]),
        mobileBankAccountId: json["mobile_bank_account_id"],
        mobileBankAccount: json["mobile_bank_account"] == null
            ? null
            : MobileBankAccount.fromJson(json["mobile_bank_account"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "status": status,
        "reject_reason": rejectReason,
        "created_at": createdAt,
        "bank_account_id": bankAccountId,
        "bank_account": bankAccount?.toJson(),
        "mobile_bank_account_id": mobileBankAccountId,
        "mobile_bank_account": mobileBankAccount?.toJson(),
      };
}

class BankAccount {
  int id;
  dynamic bankId;
  String bankName;
  String accHolderName;
  String accNumber;
  String branchName;
  String routingNumber;
  String createdAt;

  BankAccount({
    required this.id,
    required this.bankId,
    required this.bankName,
    required this.accHolderName,
    required this.accNumber,
    required this.branchName,
    required this.routingNumber,
    required this.createdAt,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
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



class MobileBankAccount {
  int id;
  dynamic mobileBankId;
  String mobileBankName;
  String accNumber;
  String type;
  String createdAt;

  MobileBankAccount({
    required this.id,
    required this.mobileBankId,
    required this.mobileBankName,
    required this.accNumber,
    required this.type,
    required this.createdAt,
  });

  factory MobileBankAccount.fromJson(Map<String, dynamic> json) =>
      MobileBankAccount(
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


class Links {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  Links({
    required this.first,
    required this.last,
    this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  dynamic currentPage;
  dynamic from;
  dynamic lastPage;
  List<Link> links;
  String path;
  dynamic perPage;
  dynamic to;
  dynamic total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
