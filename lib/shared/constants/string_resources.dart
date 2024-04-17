import 'package:home_remedies/models/response/home_remedy_model.dart';

class StringResources {
  static const String companyName = "ATRULE Technologies";
  static const String appName = "Home Remedies For Everyday Illness";
  static const bool isOnline = false;

  static List<Symptom> data = List.empty(growable: true);

  static int timeoutCode = 10000;
  static int internetIssueCode = 10001;
  static int errorCode = 10002;

  //region Api Url List
  static const String apiKeyHeader = "ApiKey";
  static const String apiKey = "YOUR_API_KEY";

  static const String homeRemediesUrl = "http://api.atrule.com/api/HomeRemedies";
  //endregion

  static const String languageOptionKey = "languageOptionKey";

  static const String storageName = "DataStorage";
  static const String dataKey = "DataKey";
  static const String cacheKey = "CachedImage";
}