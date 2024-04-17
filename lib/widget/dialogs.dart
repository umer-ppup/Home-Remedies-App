import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_remedies/common_controller/home_remedy_controller.dart';
import 'package:home_remedies/models/helper_models/language_model.dart';
import 'package:home_remedies/shared/constants/color_resources.dart';
import 'package:home_remedies/widget/custom_widget.dart';

languagePickerDialog(myContext, HomeRemedyController homeRemedyController){
  showDialog(
      barrierDismissible: true,
      context: myContext,
      builder: (BuildContext buildContext){
        return StatefulBuilder(
            builder: (context, setState){
              return Dialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5.0,
                backgroundColor: ColorResources.colorBlueLightest,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          //region clip container
                          ClipPath(
                            clipper: CustomClipPath(),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: ColorResources.colorBlue,
                              height: 200.0,
                              child: Center(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                        child: myText("language".tr, TextAlign.center, ColorResources.whiteColor, 16.0, FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //endregion

                          Positioned(
                            top: 5.0,
                            right: 5.0,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(buildContext).pop();
                              },
                              minWidth: 0,
                              visualDensity: VisualDensity.compact,
                              color: ColorResources.whiteColor,
                              textColor: ColorResources.whiteColor,
                              child: Icon(
                                Icons.clear,
                                size: 18,
                                color: ColorResources.colorBlue,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 15.0),
                          itemCount: homeRemedyController.languageOptions.length,
                          itemBuilder: (context, index) {
                            LanguageModel languageModel = homeRemedyController.languageOptions[index];
                            return GestureDetector(
                              onTap: (){
                                Navigator.of(buildContext).pop();
                                homeRemedyController.saveSelectedLanguage(languageModel.id);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 7.5),
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(
                                    color: ColorResources.darkGreyColor.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 0),
                                  )],
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  color: ColorResources.whiteColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        child: myText(languageModel.name.tr, TextAlign.left, ColorResources.colorBlue, 16.0, languageModel.isSelected ? FontWeight.bold : FontWeight.normal),
                                      ),
                                    ),
                                    Visibility(
                                      visible: languageModel.isSelected,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10.0),
                                        child: Icon(
                                          Icons.check,
                                          color: ColorResources.colorBlue,
                                          size: 24.0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
        );
      });
}