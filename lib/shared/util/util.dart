import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:home_remedies/common_controller/home_remedy_controller.dart';
import 'package:home_remedies/data/local/custom_cache_manager.dart';
import 'package:home_remedies/models/helper_models/language_model.dart';
import 'package:home_remedies/shared/constants/color_resources.dart';
import 'package:home_remedies/shared/constants/image_resources.dart';
import 'package:home_remedies/shared/constants/string_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

//region show and hide functions for progress dialog
Future showLoading() async {
  await EasyLoading.show(status: "please_wait".tr, dismissOnTap: false);
}

Future hideLoading() async {
  await EasyLoading.dismiss();
}
//endregion

//region my toast function
myToast(String text){
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorResources.colorYellow,
      textColor: ColorResources.whiteColor,
      fontSize: 16.0
  );
}
//endregion

//region image from network widget
Widget networkImageNew(String? url, double h, double w, BoxFit fit, Color progressColor, function){
  return CachedNetworkImage(
    cacheManager: CustomCacheManager.getInstance(),
    imageUrl: url != null ? url : "",
    width: w,
    height: h,
    fit: fit,
    imageBuilder: (context, imageProvider) => Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: imageProvider,
          fit: fit,
        ),
      ),
    ),
    progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress, color: progressColor,)),
    errorWidget: (context, url, error) => Container(
          height: h,
          width: w,
          child: Center(
            child: SvgPicture.asset(
              ImageResources.diseaseIcon,
              fit: BoxFit.contain,
              width: 50.0,
              height: 50.0,
            ),
          ),
        ),
  );
}
//endregion

//region Language Options
Future<List<LanguageModel>> getLanguageOptions() async {
  List<LanguageModel> languageOptions = new List<LanguageModel>.empty(growable: true);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.containsKey(StringResources.languageOptionKey)){
    if(prefs.getString(StringResources.languageOptionKey) != null){
      if(prefs.getString(StringResources.languageOptionKey) != ""){
        String? myList = prefs.getString(StringResources.languageOptionKey);
        if(myList != null){
          var result = await json.decode(myList);
          var res = result as List;
          List<LanguageModel> languageModels = res.map((x) => LanguageModel.fromJson(x)).toList();
          languageOptions.addAll(languageModels);
          updateLocale(languageOptions);
          return languageOptions;
        }
      }
    }
  }

  languageOptions.add(new LanguageModel(
      id: 1,
      name: "english",
      languageCode: "en",
      countryCode: "US",
      isSelected: true
  ));
  languageOptions.add(new LanguageModel(
      id: 2,
      name: "urdu",
      languageCode: "ur",
      countryCode: "PK",
      isSelected: false
  ));

  updateLocale(languageOptions);

  return languageOptions;
}
//endregion

//region Check string validity
String checkValidString(value){
  String s = "";

  if(value != null){
    if(value.toString().trim() != ""){
      s = value.toString().trim();
    }
  }

  return s;
}
//endregion

//region Locale update
void updateLocale(List<LanguageModel>? list){
  if(list != null){
    if(list.isNotEmpty){
      list.forEach((element) {
        if(element.isSelected){
          var locale = Locale(element.languageCode, element.countryCode);
          Get.updateLocale(locale);

          changeLanguageIdentifier();
        }
      });
    }
  }
}

void changeLanguageIdentifier(){
  HomeRemedyController homeRemedyController;

  try{
    homeRemedyController = Get.find();
  }catch(exception){
    homeRemedyController = Get.put(HomeRemedyController());
  }

  homeRemedyController.languageOptions.forEach((element) {
    if(element.isSelected){
      if(element.id == 1){
        homeRemedyController.languageEnglish = true;
      }
      else{
        homeRemedyController..languageEnglish = false;
      }
    }
  });
  homeRemedyController.update();
}
//endregion