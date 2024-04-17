import 'dart:convert';
List<HomeRemediesModel> homeRemediesModelFromJson(String str) => List<HomeRemediesModel>.from(json.decode(str).map((x) => HomeRemediesModel.fromJson(x)));
String homeRemediesModelToJson(List<HomeRemediesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeRemediesModel {
  HomeRemediesModel({
    required this.categoryId,
    required this.categoryName,
    required this.insertedTime,
    required this.categoryNavigations,
  });

  int categoryId;
  String categoryName;
  DateTime insertedTime;
  List<CategoryNavigation> categoryNavigations;

  factory HomeRemediesModel.fromJson(Map<String, dynamic> json) => HomeRemediesModel(
    categoryId: json["categoryId"] != null ? json["categoryId"] : 0,
    categoryName: json["categoryName"] != null ? json["categoryName"].toString().trim() : "",
    insertedTime: json["insertedTime"] != null ? DateTime.parse(json["insertedTime"]) : DateTime.now(),
    categoryNavigations: json["categoryNavigations"] != null ? List<CategoryNavigation>.from(json["categoryNavigations"].map((x) => CategoryNavigation.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "insertedTime": insertedTime.toIso8601String(),
    "categoryNavigations": List<dynamic>.from(categoryNavigations.map((x) => x.toJson())),
  };
}

class CategoryNavigation {
  CategoryNavigation({
    required this.subCategoryId,
    required this.remediesCategoriesId,
    required this.subCategoryName,
    required this.subCategoryNameUrdu,
    required this.insertedTime,
    required this.symptoms,
    required this.imageUrl
  });

  int subCategoryId;
  int remediesCategoriesId;
  String subCategoryName;
  String subCategoryNameUrdu;
  DateTime insertedTime;
  List<Symptom> symptoms;
  String imageUrl;

  factory CategoryNavigation.fromJson(Map<String, dynamic> json) => CategoryNavigation(
    subCategoryId: json["subCategoryId"] != null ? json["subCategoryId"] : 0,
    remediesCategoriesId: json["remediesCategoriesId"] != null ? json["remediesCategoriesId"] : 0,
    subCategoryName: json["subCategoryName"] != null ? json["subCategoryName"].toString().trim() : "",
    subCategoryNameUrdu: json["subCategoryNameUrdu"] != null ? json["subCategoryNameUrdu"].toString().trim() : "",
    insertedTime: json["insertedTime"] != null ? DateTime.parse(json["insertedTime"]) : DateTime.now(),
    symptoms: json["symptoms"] != null ? List<Symptom>.from(json["symptoms"].map((x) => Symptom.fromJson(x))) : [],
    imageUrl: json["imageUrl"] != null ? json["imageUrl"] : "",
  );

  Map<String, dynamic> toJson() => {
    "subCategoryId": subCategoryId,
    "remediesCategoriesId": remediesCategoriesId,
    "subCategoryName": subCategoryName,
    "subCategoryNameUrdu": subCategoryNameUrdu,
    "insertedTime": insertedTime.toIso8601String(),
    "symptoms": List<dynamic>.from(symptoms.map((x) => x.toJson())),
    "imageUrl": imageUrl,
  };
}

class Symptom {
  Symptom({
    required this.symptomId,
    required this.categoryNavigationId,
    required this.symptomImageUrl,
    required this.symptomName,
    required this.symptomNameUrdu,
    required this.symptomDetail,
    required this.symptomDetailUrdu,
    required this.insertedTime,
    required this.symptomRemedies,
    required this.symptomIndication,
    required this.symptomCauses,
  });

  int symptomId;
  int categoryNavigationId;
  String symptomImageUrl;
  String symptomName;
  String symptomNameUrdu;
  String symptomDetail;
  String symptomDetailUrdu;
  DateTime insertedTime;
  List<SymptomRemedy> symptomRemedies;
  List<SymptomIndication> symptomIndication;
  List<SymptomCause> symptomCauses;

  factory Symptom.fromJson(Map<String, dynamic> json) => Symptom(
    symptomId: json["symptomId"] != null ? json["symptomId"] : 0,
    categoryNavigationId: json["categoryNavigationId"] != null ? json["categoryNavigationId"] : 0,
    symptomImageUrl: json["symptomImageUrl"] != null ? json["symptomImageUrl"] : "",
    symptomName: json["symptomName"] != null ? json["symptomName"].toString().trim() : "",
    symptomNameUrdu: json["symptomNameUrdu"] != null ? json["symptomNameUrdu"].toString().trim() : "",
    symptomDetail: json["symptomDetail"] != null ? json["symptomDetail"].toString().trim() : "",
    symptomDetailUrdu: json["symptomDetailUrdu"] != null ? json["symptomDetailUrdu"].toString().trim() : "",
    insertedTime: json["insertedTime"] != null ? DateTime.parse(json["insertedTime"]) : DateTime.now(),
    symptomRemedies: json["symptomRemedies"] != null ? List<SymptomRemedy>.from(json["symptomRemedies"].map((x) => SymptomRemedy.fromJson(x))) : [],
    symptomIndication: json["symptomIndication"] != null ? List<SymptomIndication>.from(json["symptomIndication"].map((x) => SymptomIndication.fromJson(x))) : [],
    symptomCauses: json["symptomCauses"] != null ? List<SymptomCause>.from(json["symptomCauses"].map((x) => SymptomCause.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "symptomId": symptomId,
    "categoryNavigationId": categoryNavigationId,
    "symptomImageUrl": symptomImageUrl,
    "symptomName": symptomName,
    "symptomNameUrdu": symptomNameUrdu,
    "symptomDetail": symptomDetail,
    "symptomDetailUrdu": symptomDetailUrdu,
    "insertedTime": insertedTime.toIso8601String(),
    "symptomRemedies": List<dynamic>.from(symptomRemedies.map((x) => x.toJson())),
    "symptomIndication": List<dynamic>.from(symptomIndication.map((x) => x.toJson())),
    "symptomCauses": List<dynamic>.from(symptomCauses.map((x) => x.toJson())),
  };
}

class SymptomRemedy {
  SymptomRemedy({
    required this.remedyId,
    required this.symptomId,
    required this.remedyImageUrl,
    required this.remedyName,
    required this.remedyNameUrdu,
    required this.insertedTime,
    required this.remedyDetails,
  });

  int remedyId;
  int symptomId;
  String remedyImageUrl;
  String remedyName;
  String remedyNameUrdu;
  DateTime insertedTime;
  List<RemedyDetail> remedyDetails;

  factory SymptomRemedy.fromJson(Map<String, dynamic> json) => SymptomRemedy(
    remedyId: json["remedyId"] != null ? json["remedyId"] : 0,
    symptomId: json["symptomId"] != null ? json["symptomId"] : 0,
    remedyImageUrl: json["remedyImageUrl"] != null ? json["remedyImageUrl"] : "",
    remedyName: json["remedyName"] != null ? json["remedyName"].toString().trim() : "",
    remedyNameUrdu: json["remedyNameUrdu"] != null ? json["remedyNameUrdu"].toString().trim() : "",
    insertedTime: json["insertedTime"] != null ? DateTime.parse(json["insertedTime"]) : DateTime.now(),
    remedyDetails: json["remedyDetails"] != null ? List<RemedyDetail>.from(json["remedyDetails"].map((x) => RemedyDetail.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "remedyId": remedyId,
    "symptomId": symptomId,
    "remedyImageUrl": remedyImageUrl,
    "remedyName": remedyName,
    "remedyNameUrdu": remedyNameUrdu,
    "insertedTime": insertedTime.toIso8601String(),
    "remedyDetails": List<dynamic>.from(remedyDetails.map((x) => x.toJson())),
  };
}

class SymptomCause {
  SymptomCause({
    required this.causesId,
    required this.symptomId,
    required this.causes,
    required this.causesUrdu
  });

  int causesId;
  int symptomId;
  String causes;
  String causesUrdu;

  factory SymptomCause.fromJson(Map<String, dynamic> json) => SymptomCause(
    causesId: json["causesId"] != null ? json["causesId"] : -1,
    symptomId: json["symptomId"] != null ? json["symptomId"] : -1,
    causes: json["causes"] != null ? json["causes"].toString().trim() : "",
    causesUrdu: json["causesUrdu"] != null ? json["causesUrdu"].toString().trim() : ""
  );

  Map<String, dynamic> toJson() => {
    "causesId": causesId,
    "symptomId": symptomId,
    "causes": causes,
    "causesUrdu": causesUrdu,
  };
}

class SymptomIndication {
  SymptomIndication({
    required this.indicationId,
    required this.symptomId,
    required this.indications,
    required this.indicationsUrdu
  });

  int indicationId;
  int symptomId;
  String indications;
  String indicationsUrdu;

  factory SymptomIndication.fromJson(Map<String, dynamic> json) => SymptomIndication(
    indicationId: json["indicationId"] != null ? json["indicationId"] : -1,
    symptomId: json["symptomId"] != null ? json["symptomId"] : -1,
    indications: json["indications"] != null ? json["indications"].toString().trim() : "",
    indicationsUrdu: json["indicationsUrdu"] != null ? json["indicationsUrdu"].toString().trim() : "",
  );

  Map<String, dynamic> toJson() => {
    "indicationId": indicationId,
    "symptomId": symptomId,
    "indications": indications,
    "indicationsUrdu": indicationsUrdu,
  };
}

class RemedyDetail {
  RemedyDetail({
    required this.remedyDetailId,
    required this.symptomRemediesId,
    required this.remedyDetailStep,
    required this.remedyDetailValue,
    required this.remedyDetailValueUrdu,
    required this.insertedTime,
  });

  int remedyDetailId;
  int symptomRemediesId;
  String remedyDetailStep;
  String remedyDetailValue;
  String remedyDetailValueUrdu;
  DateTime insertedTime;

  factory RemedyDetail.fromJson(Map<String, dynamic> json) => RemedyDetail(
    remedyDetailId: json["remedyDetailId"] != null ? json["remedyDetailId"] : 0,
    symptomRemediesId: json["symptomRemediesId"] != null ? json["symptomRemediesId"] : 0,
    remedyDetailStep: json["remedyDetailStep"] != null ? json["remedyDetailStep"].toString().trim() : "",
    remedyDetailValue: json["remedyDetailValue"] != null ? json["remedyDetailValue"].toString().trim() : "",
    remedyDetailValueUrdu: json["remedyDetailValueUrdu"] != null ? json["remedyDetailValueUrdu"].toString().trim() : "",
    insertedTime: json["insertedTime"] != null ? DateTime.parse(json["insertedTime"]) : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "remedyDetailId": remedyDetailId,
    "symptomRemediesId": symptomRemediesId,
    "remedyDetailStep": remedyDetailStep,
    "remedyDetailValue": remedyDetailValue,
    "remedyDetailValueUrdu": remedyDetailValueUrdu,
    "insertedTime": insertedTime.toIso8601String(),
  };
}
