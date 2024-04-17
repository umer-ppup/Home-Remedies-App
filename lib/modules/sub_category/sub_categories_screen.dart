import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
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
import 'package:home_remedies/widget/dialogs.dart';

// ignore: must_be_immutable
class SubCategoriesScreen extends StatefulWidget {
  SubCategoriesScreen({Key? key}) : super(key: key);

  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  DateTime? currentBackPressTime;
  late HomeRemedyController homeRemedyController;

  Future<void> pullRefresh() async {
    homeRemedyController.fetchHomeRemedies();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      myToast("press_again_to_exit".tr);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    try{
      homeRemedyController = Get.find();
      homeRemedyController.fetchHomeRemedies();
    }catch(exception){
      homeRemedyController = Get.put(HomeRemedyController());
      homeRemedyController.fetchHomeRemedies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          var result = snapshot.data;
          switch (result) {
            case ConnectivityResult.none:
              break;
            case ConnectivityResult.mobile:
            case ConnectivityResult.wifi:
              Timer(Duration(seconds: 5), () {
                if(homeRemedyController.homeRemediesList.isEmpty && !homeRemedyController.isLoading){
                  homeRemedyController.fetchHomeRemedies();
                }
              });
              break;
            default:
              break;
          }
          return myBody();
        },
      ),
    );
  }

  Widget myBody(){
    return GetBuilder<HomeRemedyController>(
      init: HomeRemedyController(),
      id: 'sub_category_screen',
      builder: (_) =>  Scaffold(
        backgroundColor: ColorResources.colorBlueLightest,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                //region clip container code
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
                      languagePickerDialog(context, homeRemedyController);
                    },
                    minWidth: 0,
                    color: ColorResources.whiteColor,
                    textColor: ColorResources.whiteColor,
                    child: Icon(
                      Icons.language,
                      size: 24,
                      color: ColorResources.colorBlue,
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
                      child: Center(
                        child: RefreshIndicator(
                          color: ColorResources.colorBlue,
                          backgroundColor: ColorResources.whiteColor,
                          onRefresh: pullRefresh,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  homeRemedyController.isLoading == true ? Container(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor: new AlwaysStoppedAnimation<Color>(ColorResources.colorBlue),
                                      ),
                                    ),
                                  ) : homeRemedyController.homeRemediesList.isEmpty && !homeRemedyController.isLoading ?
                                  emptyContainer(context, homeRemedyController.errorMessage, (){homeRemedyController.fetchHomeRemedies();}) :
                                  homeRemedyController.homeRemediesList[0].categoryNavigations.isEmpty && !homeRemedyController.isLoading ?
                                  emptyContainer(context, homeRemedyController.errorMessage, (){homeRemedyController.fetchHomeRemedies();}) :
                                  Container(
                                    child: GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 13,
                                          childAspectRatio: 1/1.1,
                                        ),
                                        shrinkWrap: true,
                                        itemCount: homeRemedyController.homeRemediesList[0].categoryNavigations.length,
                                        itemBuilder: (buildContext, index) {
                                          CategoryNavigation categoryNavigation = homeRemedyController.homeRemediesList[0].categoryNavigations[index];
                                          return InkWell(
                                            onTap: () async {
                                              homeRemedyController.selectSubCategories(context, index);
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
                                                    child: checkValidString(categoryNavigation.imageUrl) != "" ? Container(
                                                      child: networkImageNew("http://api.atrule.com${categoryNavigation.imageUrl}", double.infinity, double.infinity, BoxFit.fill, ColorResources.colorBlue, (){}),
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
                                                    child: myTextWidgetMaxLine(homeRemedyController.languageEnglish ? categoryNavigation.subCategoryName : categoryNavigation.subCategoryNameUrdu, TextAlign.center, ColorResources.colorBlue, 14, FontWeight.bold, 3),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
                //endregion
              ],
            ),
          ),
        ),
      ),
    );
  }
}
