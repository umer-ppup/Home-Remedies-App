import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_remedies/common_controller/home_remedy_controller.dart';
import 'package:home_remedies/models/response/home_remedy_model.dart';
import 'package:home_remedies/shared/constants/color_resources.dart';
import 'package:home_remedies/shared/constants/image_resources.dart';
import 'package:home_remedies/shared/constants/string_resources.dart';
import 'package:home_remedies/shared/util/util.dart';
import 'package:home_remedies/widget/custom_widget.dart';

// ignore: must_be_immutable
class DiseaseScreen extends StatefulWidget {
  DiseaseScreen({Key? key}) : super(key: key);

  @override
  _DiseaseScreenState createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
  late HomeRemedyController homeRemedyController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    try{
      homeRemedyController = Get.find();
    }catch(exception){
      homeRemedyController = Get.put(HomeRemedyController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) {
          return Scaffold(
            backgroundColor: ColorResources.colorBlueLightest,
            body: SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    //region clip container
                    ClipPath(
                      clipper: CustomClipPath(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: ColorResources.colorBlue,
                        height: 200.0,
                      ),
                    ),
                    //endregion

                    //region back arrow widget
                    Positioned(
                      top: 5.0,
                      left: 5.0,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        minWidth: 0,
                        color: ColorResources.whiteColor,
                        textColor: ColorResources.whiteColor,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 24,
                            color: ColorResources.colorBlue,
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        shape: CircleBorder(),
                      ),
                    ),
                    //endregion

                    //region search widget
                    Positioned(
                      top: 5.0,
                      right: 5.0,
                      child: MaterialButton(
                        onPressed: () async {
                          if(StringResources.data.isNotEmpty){
                            await showLoading();
                            showSearch(context: context, delegate: MySearchModel(homeRemedyController));
                            await hideLoading();
                          }
                          else{
                            myToast("do_not_have_data".tr);
                          }
                        },
                        minWidth: 0,
                        color: ColorResources.whiteColor,
                        textColor: ColorResources.whiteColor,
                        child: Icon(
                          Icons.search,
                          size: 24,
                          color: ColorResources.colorBlue,
                        ),
                        padding: EdgeInsets.all(8),
                        shape: CircleBorder(),
                      ),
                    ),
                    //endregion

                    //region top text and list
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  child: myText("home_remedies".tr, TextAlign.center, ColorResources.whiteColor, 28, FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 70.0,
                        ),
                        Expanded(
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 13,
                                childAspectRatio: 1/1.1,
                              ),
                              shrinkWrap: true,
                              itemCount: homeRemedyController.homeRemediesList[homeRemedyController.categoryIndex].categoryNavigations[homeRemedyController.subCategoryIndex].symptoms.length,
                              itemBuilder: (buildContext, index) {
                                Symptom symptom = homeRemedyController.homeRemediesList[homeRemedyController.categoryIndex].categoryNavigations[homeRemedyController.subCategoryIndex].symptoms[index];
                                return InkWell(
                                  onTap: () async {
                                    homeRemedyController.selectSymptoms(context, index);
                                  },
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
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
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: checkValidString(symptom.symptomImageUrl) != "" ? Container(
                                            child: networkImageNew("http://api.atrule.com${symptom.symptomImageUrl}", double.infinity, double.infinity, BoxFit.fill, ColorResources.colorBlue, (){}),
                                          ) : Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            child: Center(
                                              child: SvgPicture.asset(
                                                ImageResources.diseaseIcon,
                                                fit: BoxFit.contain,
                                                width: 50.0,
                                                height: 50.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
                                          child: myTextWidgetMaxLine(homeRemedyController.languageEnglish ? symptom.symptomName : symptom.symptomNameUrdu, TextAlign.center, ColorResources.colorBlue, 14, FontWeight.bold, 3),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    )
                    //endregion
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
