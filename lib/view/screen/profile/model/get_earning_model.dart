// To parse this JSON data, do
//
//     final earningHistoryModel = earningHistoryModelFromJson(jsonString);

import 'dart:convert';

EarningHistoryModel earningHistoryModelFromJson(String str) =>
    EarningHistoryModel.fromJson(json.decode(str));

String earningHistoryModelToJson(EarningHistoryModel data) =>
    json.encode(data.toJson());

class EarningHistoryModel {
  List<EarningDatum> data;
  Links links;
  Meta meta;
  bool status;
  String message;

  EarningHistoryModel({
    required this.data,
    required this.links,
    required this.meta,
    required this.status,
    required this.message,
  });

  factory EarningHistoryModel.fromJson(Map<String, dynamic> json) =>
      EarningHistoryModel(
        data: List<EarningDatum>.from(
            json["data"].map((x) => EarningDatum.fromJson(x))),
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

class EarningDatum {
  String userId;
  String phone;
  dynamic amount;
  String description;
  String createdAt;

  EarningDatum({
    required this.userId,
    required this.phone,
    required this.amount,
    required this.description,
    required this.createdAt,
  });

  factory EarningDatum.fromJson(Map<String, dynamic> json) => EarningDatum(
        userId: json["user_id"],
        phone: json["phone"],
        amount: json["amount"],
        description: json["description"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "phone": phone,
        "amount": amount,
        "description": description,
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
  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

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
