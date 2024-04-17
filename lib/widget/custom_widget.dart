import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_remedies/common_controller/home_remedy_controller.dart';
import 'package:home_remedies/models/response/home_remedy_model.dart';
import 'package:home_remedies/modules/remedy/remedy_screen.dart';
import 'package:home_remedies/shared/constants/color_resources.dart';
import 'package:home_remedies/shared/constants/image_resources.dart';
import 'package:home_remedies/shared/constants/string_resources.dart';
import 'package:home_remedies/shared/util/util.dart';

//region delegate class for search functionality
class MySearchModel extends SearchDelegate<Symptom> {
  List<Symptom> symptom = StringResources.data;
  HomeRemedyController homeRemedyController;

  MySearchModel(this.homeRemedyController) : super(searchFieldLabel: "search_hint".tr);

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear, color: ColorResources.whiteColor, size: 24.0,),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back, color: ColorResources.whiteColor, size: 24.0,),
      onPressed: () {
        close(context, StringResources.data[0]);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return ListTile(
      title: myText(query, TextAlign.left, ColorResources.colorBlue, 16, FontWeight.bold),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    var myList;
    if(homeRemedyController.languageEnglish){
      myList = query.isEmpty ? symptom : symptom.where((element) => element.symptomName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    else{
      myList = query.isEmpty ? symptom : symptom.where((element) => element.symptomNameUrdu.toLowerCase().contains(query.toLowerCase())).toList();
    }

    return myList.isEmpty
        ? ListTile(
      title: myText("no_result_found".tr, TextAlign.left, ColorResources.colorBlue, 16, FontWeight.bold),
    )
        : ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      itemCount: myList.length,
      itemBuilder: (context, index) {
        final Symptom myModel = myList[index];
        return InkWell(
          onTap: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => RemedyScreen(symptom: myModel)));
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            width: double.infinity,
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
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResources.smokeWhiteColor
                  ),
                  child: checkValidString(myModel.symptomImageUrl) != "" ?
                  networkImageNew("http://api.atrule.com${myModel.symptomImageUrl}", 70.0, 70.0, BoxFit.fill, ColorResources.colorBlue, (){})
                  : Center(
                    child: SvgPicture.asset(
                      ImageResources.diseaseIcon,
                      fit: BoxFit.contain,
                      width: 50.0,
                      height: 50.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: myText(homeRemedyController.languageEnglish ? myModel.symptomName : myModel.symptomNameUrdu, TextAlign.left, ColorResources.colorBlue, 16, FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 50.0,
                        height: 50.0,
                        child: SvgPicture.asset(
                          ImageResources.remedyIcon,
                          semanticsLabel: 'Remedies',
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
//endregion

//region top clip path code
class CustomClipPath extends CustomClipper<Path> {
  var radius=10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height,
        size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
//endregion

//region my custom text widget
Widget myTextWithFontFamily(String? title, TextAlign textAlign, Color color, double fontSize, String fontFamily){
  return Text(
      title ?? "",
      textAlign: textAlign,
      style: myTextStyleWithFontFamily(fontSize, color, fontFamily)
  );
}

Widget myText(String? title, TextAlign textAlign, Color color, double fontSize, FontWeight fontWeight){
  return Text(
      title ?? "",
      textAlign: textAlign,
      style: myTextStyle(fontSize, color, fontWeight)
  );
}

TextStyle myTextStyle(double fontSize, Color textColor, FontWeight fontWeight) {
  return TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: textColor
  );
}

TextStyle myTextStyleWithFontFamily(double fontSize, Color textColor, String fontFamily) {
  return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: textColor
  );
}
//endregion

//region my custom text widget for two line
Widget myTextWidgetMaxLine(String? title, TextAlign textAlign, Color color, double fontSize, FontWeight fontWeight, int maxLines){
  return Text(
      title ?? "",
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: myTextStyle(fontSize, color, fontWeight)
  );
}
//endregion

Widget emptyContainer(BuildContext context, String message, Function()? onPress){
  return Container(
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
            color: ColorResources.whiteColor,
            child: Image.asset(
              ImageResources.no_data_found,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: myText(message.tr, TextAlign.justify, ColorResources.colorBlue, 14.0, FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    )
                ),
                visualDensity: VisualDensity.compact,
                backgroundColor: MaterialStateProperty.all(ColorResources.colorBlue),
                overlayColor: MaterialStateProperty.all(ColorResources.colorBlueLight),
                animationDuration: Duration(milliseconds: 3, microseconds: 0),
              ),
              onPressed: onPress,
              child: myText("re_try".tr, TextAlign.center, ColorResources.whiteColor, 14.0, FontWeight.bold),
            ),
          )
        ],
      ),
    ),
  );
}

Widget bulletListContainer(String text){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorResources.colorBlue,
        ),
      ),
      SizedBox(
        width: 10.0,
      ),
      Expanded(
        child: myText(text, TextAlign.start, ColorResources.colorBlue, 16, FontWeight.normal),
      )
    ],
  );
}