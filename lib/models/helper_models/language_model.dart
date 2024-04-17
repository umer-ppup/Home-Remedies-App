import 'dart:convert';

List<LanguageModel> languageModelFromJson(String str) => List<LanguageModel>.from(json.decode(str).map((x) => LanguageModel.fromJson(x)));

String languageModelToJson(List<LanguageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LanguageModel {
  LanguageModel({
    required this.id,
    required this.name,
    required this.languageCode,
    required this.countryCode,
    required this.isSelected,
  });

  int id;
  String name;
  String languageCode;
  String countryCode;
  bool isSelected;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
    id: json["id"],
    name: json["name"],
    languageCode: json["language_code"],
    countryCode: json["country_code"],
    isSelected: json["is_selected"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "language_code": languageCode,
    "country_code": countryCode,
    "is_selected": isSelected,
  };
}