
import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  bool status;
  String message;
  List<FaqDatum> data;

  FaqModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        status: json["status"],
        message: json["message"],
        data: List<FaqDatum>.from(json["data"].map((x) => FaqDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FaqDatum {
  String title;
  String description;

  FaqDatum({
    required this.title,
    required this.description,
  });

  factory FaqDatum.fromJson(Map<String, dynamic> json) => FaqDatum(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
