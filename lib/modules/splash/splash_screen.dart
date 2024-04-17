import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:home_remedies/modules/sub_category/sub_categories_screen.dart';
import 'package:home_remedies/shared/constants/color_resources.dart';
import 'package:home_remedies/shared/constants/font_resources.dart';
import 'package:home_remedies/shared/constants/image_resources.dart';
import 'package:home_remedies/shared/constants/string_resources.dart';
import 'package:home_remedies/widget/custom_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: ColorResources.whiteColor,
        body: Column(
          children: [
            //region middle area of splash
            Expanded(
              flex: 3,
              child: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 120.0,
                        height: 120.0,
                        child: Image.asset(
                          ImageResources.homeRemediesIcon,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: myTextWithFontFamily("Home Remedies For Everyday Illness", TextAlign.center, ColorResources.colorBlue, 18.0, FontResources.splashFont2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //endregion

            //region bottom area where have company information
            Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      clipBehavior: Clip.antiAlias,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.whiteColor,
                      ),
                      child: Image.asset(
                        ImageResources.atruleIcon,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    myText(StringResources.companyName, TextAlign.left, ColorResources.colorBlue, 16, FontWeight.bold),
                  ],
                ),
              ),
            )
            //endregion
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    EasyLoading.instance
      ..userInteractions = false;

    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => SubCategoriesScreen()));
    });
  }
}
