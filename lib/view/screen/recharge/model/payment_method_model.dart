
import 'dart:convert';

PaymentMethodModel paymentMethodModelFromJson(String str) =>
    PaymentMethodModel.fromJson(json.decode(str));

String paymentMethodModelToJson(PaymentMethodModel data) =>
    json.encode(data.toJson());

class PaymentMethodModel {
  List<Datum> data;
  bool status;
  String message;

  PaymentMethodModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Datum {
  int id;
  String name;
  String icon;
  String accountNumber;
  String instruction;
  List<String> instructionImages;

  Datum({
    required this.id,
    required this.name,
    required this.icon,
    required this.accountNumber,
    required this.instruction,
    required this.instructionImages,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        accountNumber: json["account_number"],
        instruction: json["instruction"],
        instructionImages:
            List<String>.from(json["instruction_images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "account_number": accountNumber,
        "instruction": instruction,
        "instruction_images":
            List<dynamic>.from(instructionImages.map((x) => x)),
      };
}
