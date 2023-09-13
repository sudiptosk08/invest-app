import 'dart:convert';

RechargeHistoryModel rechargeHistoryModelFromJson(String str) =>
    RechargeHistoryModel.fromJson(json.decode(str));

String rechargeHistoryModelToJson(RechargeHistoryModel data) =>
    json.encode(data.toJson());

class RechargeHistoryModel {
  List<RechargeHistoryDatum> data;
  Links links;
  Meta meta;
  bool status;
  String message;

  RechargeHistoryModel({
    required this.data,
    required this.links,
    required this.meta,
    required this.status,
    required this.message,
  });

  factory RechargeHistoryModel.fromJson(Map<String, dynamic> json) =>
      RechargeHistoryModel(
        data: List<RechargeHistoryDatum>.from(
            json["data"].map((x) => RechargeHistoryDatum.fromJson(x))),
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

class RechargeHistoryDatum {
  int id;
  int amount;
  String transactionId;
  String image;
  String paymentMethod;
  String status;
  String createdAt;

  RechargeHistoryDatum(
      {required this.id,
      required this.amount,
      required this.transactionId,
      required this.image,
      required this.paymentMethod,
      required this.status,
      required this.createdAt});

  factory RechargeHistoryDatum.fromJson(Map<String, dynamic> json) =>
      RechargeHistoryDatum(
        id: json["id"],
        amount: json["amount"],
        transactionId: json["trx_id"],
        image: json["image"],
        paymentMethod: json["payment_method"],
        status: json["status"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "trx_id": transactionId,
        "image": image,
        "payment_method": paymentMethod,
        "status": status,
        "created_at": createdAt
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
  dynamic path;
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
