import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_remedies/data/network/api/request.dart';
import 'package:home_remedies/models/helper_models/language_model.dart';
import 'package:home_remedies/models/response/home_remedy_model.dart';
import 'package:home_remedies/modules/disease/disease_screen.dart';
import 'package:home_remedies/modules/remedy/remedy_screen.dart';
import 'package:home_remedies/shared/constants/string_resources.dart';
import 'package:home_remedies/shared/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';

class HomeRemedyController extends GetxController {
  List<LanguageModel> languageOptions = new List<LanguageModel>.empty(growable: true);
  List<HomeRemediesModel> homeRemediesList = new List<HomeRemediesModel>.empty(growable: true);
  bool isLoading = false;
  int categoryIndex = 0;
  late int subCategoryIndex, symptomIndex;

  String errorMessage = "";

  bool languageEnglish = true;

  GetStorage localDataStorage = GetStorage(StringResources.storageName);
  String localDataValue = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLanguageOptions().then((value){
      languageOptions.addAll(value);
      update();
      changeLanguageIdentifier();
    });

    if(localDataStorage.read(StringResources.dataKey) != null){
      localDataValue = localDataStorage.read(StringResources.dataKey);
    }
    else{
      localDataValue = "";
    }
  }

  void fetchHomeRemedies()  async {
    if(localDataValue != ""){
      var result = await json.decode(localDataValue);
      if(result !=  null){
        if(homeRemediesList.isNotEmpty){
          homeRemediesList.clear();
        }
        var res = result as List;
        List<HomeRemediesModel> resultListFromResult = res.map((x) => HomeRemediesModel.fromJson(x)).toList();
        homeRemediesList.addAll(resultListFromResult);

        if(StringResources.data.isNotEmpty){
          StringResources.data.clear();
        }
        homeRemediesList.forEach((remedyModel) {
          remedyModel.categoryNavigations.forEach((categoryNavigation) {
            categoryNavigation.symptoms.forEach((symptom) {
              StringResources.data.add(symptom);
            });
          });
        });
      }
    }
    else{
      isLoading = true;
      update(['sub_category_screen'], true);
    }

    Request request = Request(url: StringResources.homeRemediesUrl);
    request.get().then((value) async {
      if(value.statusCode == 200){
        try{
          localDataStorage.write(StringResources.dataKey, value.body.toString());
          if(localDataStorage.read(StringResources.dataKey) != null){
            localDataValue = localDataStorage.read(StringResources.dataKey);
          }
          else{
            localDataValue = "";
          }

          var result = await json.decode(value.body);
          if(result !=  null){
            if(homeRemediesList.isNotEmpty){
              homeRemediesList.clear();
            }
            var res = result as List;
            List<HomeRemediesModel> resultListFromResult = res.map((x) => HomeRemediesModel.fromJson(x)).toList();
            homeRemediesList.addAll(resultListFromResult);

            if(StringResources.data.isNotEmpty){
              StringResources.data.clear();
            }
            homeRemediesList.forEach((remedyModel) {
              remedyModel.categoryNavigations.forEach((categoryNavigation) {
                categoryNavigation.symptoms.forEach((symptom) {
                  StringResources.data.add(symptom);
                });
              });
            });
          }
          else{
            errorMessage = "no_result_found";
            myToast(errorMessage.tr);
          }
        } catch(exception){
          errorMessage = "no_result_found";
          myToast(errorMessage.tr);
        }
      }
      else if(value.statusCode == StringResources.timeoutCode){
        errorMessage = "timeout_error";
        myToast(errorMessage.tr);
      }
      else if(value.statusCode == StringResources.internetIssueCode){
        errorMessage = "no_internet_error";
        myToast(errorMessage.tr);
      }
      else if(value.statusCode == StringResources.errorCode){
        errorMessage = "error_message";
        myToast(errorMessage.tr);
      }
      else{
        errorMessage = "error_message";
        myToast(errorMessage.tr);
      }

      isLoading = false;
      update(['sub_category_screen'], true);
    });
  }

  // void selectCategories(BuildContext context, int index)  async {
  //   categoryIndex = index;
  //   update();
  //
  //   if(homeRemediesList[categoryIndex].categoryNavigations != null){
  //     if(homeRemediesList[categoryIndex].categoryNavigations.isNotEmpty){
  //       await showLoading();
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (BuildContext context) => SubCategoriesScreen()));
  //       await hideLoading();
  //     }
  //     else{
  //       myToast("empty_data_for".trParams({
  //         'name': '${homeRemediesList[categoryIndex].categoryName}'
  //       }));
  //     }
  //   }
  // }

  void selectSubCategories(BuildContext context, int index)  async {
    subCategoryIndex = index;
    update(['sub_category_screen'], true);

    if(homeRemediesList[categoryIndex].categoryNavigations[subCategoryIndex].symptoms.isNotEmpty){
      await showLoading();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => DiseaseScreen()));
      await hideLoading();
    }
    else{
      myToast("empty_data_for".trParams({
        'name': '${languageEnglish ? homeRemediesList[categoryIndex].categoryNavigations[subCategoryIndex].subCategoryName : homeRemediesList[categoryIndex].categoryNavigations[subCategoryIndex].subCategoryNameUrdu}'
      }));
    }
  }

  void selectSymptoms(BuildContext context, int index)  async {
    symptomIndex = index;
    update();

    await showLoading();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => RemedyScreen(symptom: homeRemediesList[categoryIndex].categoryNavigations[subCategoryIndex].symptoms[symptomIndex],)));
    await hideLoading();
  }

  void saveSelectedLanguage(int languageId)  async {
    if(languageOptions.isNotEmpty){
      List<LanguageModel> latestList = List.empty(growable: true);

      languageOptions.forEach((element) {
        if(element.id == languageId){
          LanguageModel languageModel = new LanguageModel(id: element.id, name: element.name, languageCode: element.languageCode, countryCode: element.countryCode, isSelected: true);
          latestList.add(languageModel);
        }
        else{
          LanguageModel languageModel = new LanguageModel(id: element.id, name: element.name, languageCode: element.languageCode, countryCode: element.countryCode, isSelected: false);
          latestList.add(languageModel);
        }
      });

      languageOptions.clear();
      languageOptions.addAll(latestList);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(StringResources.languageOptionKey, json.encode(List<dynamic>.from(languageOptions.map((x) => x.toJson()))));

      updateLocale(languageOptions);

      update();
    }
  }
}