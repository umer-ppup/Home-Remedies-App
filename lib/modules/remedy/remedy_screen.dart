import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_remedies/common_controller/home_remedy_controller.dart';
import 'package:home_remedies/models/response/home_remedy_model.dart';
import 'package:home_remedies/shared/constants/color_resources.dart';
import 'package:home_remedies/shared/constants/image_resources.dart';
import 'package:home_remedies/shared/util/util.dart';
import 'package:home_remedies/widget/custom_widget.dart';

// ignore: must_be_immutable
class RemedyScreen extends StatefulWidget {
  Symptom symptom;
  RemedyScreen({Key? key, required this.symptom}) : super(key: key);

  @override
  _RemedyScreenState createState() => _RemedyScreenState();
}

class _RemedyScreenState extends State<RemedyScreen> {
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
    return Scaffold(
      backgroundColor: ColorResources.colorBlueLightest,
      appBar: AppBar(
        title: myText(homeRemedyController.languageEnglish ? widget.symptom.symptomName : widget.symptom.symptomNameUrdu, TextAlign.left, ColorResources.whiteColor, 16, FontWeight.bold),
        iconTheme: IconThemeData(color: ColorResources.whiteColor),
        elevation: 5.0,
        backgroundColor: ColorResources.colorBlue
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                Visibility(
                  visible: homeRemedyController.languageEnglish ? (widget.symptom.symptomDetail.trim() != "") : (widget.symptom.symptomDetailUrdu.trim() != ""),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: myText("detail".tr, TextAlign.start, ColorResources.colorBlue, 16.0, FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 5.0),
                                child: myText("\t\t\t\t\t${homeRemedyController.languageEnglish ? widget.symptom.symptomDetail : widget.symptom.symptomDetailUrdu}", TextAlign.justify, ColorResources.colorBlue, 16.0, FontWeight.normal),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.symptom.symptomIndication.isNotEmpty,
                  child: Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: myText(homeRemedyController.languageEnglish ? (widget.symptom.symptomName.trim() != "" ?
                                "symptoms_of".trParams({
                                  "name": "${homeRemedyController.languageEnglish ? widget.symptom.symptomName.trim() : widget.symptom.symptomNameUrdu.trim()}"
                                })
                                : "symptoms".tr) : (widget.symptom.symptomNameUrdu.trim() != "" ?
                                "symptoms_of".trParams({
                                  "name": "${homeRemedyController.languageEnglish ? widget.symptom.symptomName.trim() : widget.symptom.symptomNameUrdu.trim()}"
                                })
                                    : "symptoms".tr), TextAlign.start, ColorResources.colorBlue, 16.0, FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                          scrollDirection: Axis.vertical,
                          itemCount: widget.symptom.symptomIndication.length,
                          itemBuilder: (BuildContext context, int index) {
                            SymptomIndication symptomIndication = widget.symptom.symptomIndication[index];
                            return (homeRemedyController.languageEnglish ? symptomIndication.indications.trim() != "" ? true : false : symptomIndication.indicationsUrdu.trim() != "" ? true : false) ?
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: bulletListContainer(homeRemedyController.languageEnglish ? symptomIndication.indications : symptomIndication.indicationsUrdu),
                            ) : Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.symptom.symptomCauses.isNotEmpty,
                  child: Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: myText(homeRemedyController.languageEnglish ? (widget.symptom.symptomName.trim() != "" ?
                                "causes_of".trParams({
                                  "name": "${homeRemedyController.languageEnglish ? widget.symptom.symptomName.trim() : widget.symptom.symptomNameUrdu.trim()}"
                                })
                                : "causes".tr) : (widget.symptom.symptomNameUrdu.trim() != "" ?
                                "causes_of".trParams({
                                  "name": "${homeRemedyController.languageEnglish ? widget.symptom.symptomName.trim() : widget.symptom.symptomNameUrdu.trim()}"
                                })
                                    : "causes".tr), TextAlign.start, ColorResources.colorBlue, 16.0, FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                          scrollDirection: Axis.vertical,
                          itemCount: widget.symptom.symptomCauses.length,
                          itemBuilder: (BuildContext context, int index) {
                            SymptomCause symptomCause = widget.symptom.symptomCauses[index];
                            return (homeRemedyController.languageEnglish ? symptomCause.causes.trim() != "" ? true : false : symptomCause.causesUrdu.trim() != "" ? true : false) ?
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: bulletListContainer(homeRemedyController.languageEnglish ? symptomCause.causes : symptomCause.causesUrdu),
                            ) : Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                //region remedies list
                Visibility(
                  visible: widget.symptom.symptomRemedies.isNotEmpty,
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 20.0),
                                child: myText("remedies".tr, TextAlign.center, ColorResources.colorBlue, 16.0, FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 5.0),
                            scrollDirection: Axis.vertical,
                            itemCount: widget.symptom.symptomRemedies.length,
                            itemBuilder: (BuildContext context, int index) {
                              SymptomRemedy symptomRemedy = widget.symptom.symptomRemedies[index];
                              return Container(
                                margin: EdgeInsets.only(top: 15.0),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 200.0,
                                            child: checkValidString(symptomRemedy.remedyImageUrl) != "" ?
                                            networkImageNew("http://api.atrule.com${symptomRemedy.remedyImageUrl}", 200.0, double.infinity, BoxFit.fill, ColorResources.colorBlue, (){})
                                            : Container(
                                              height: 200.0,
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
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0.0),
                                                bottomLeft: Radius.circular(0.0),
                                                bottomRight: Radius.circular(20.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                              color: ColorResources.colorBlue.withOpacity(0.7),
                                            ),
                                            child: myText("${index + 1}", TextAlign.center, ColorResources.whiteColor, 16, FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: homeRemedyController.languageEnglish ? (symptomRemedy.remedyName.trim() != "" ? true : false) : (symptomRemedy.remedyNameUrdu.trim() != "" ? true : false),
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                        child: myText(homeRemedyController.languageEnglish ? symptomRemedy.remedyName : symptomRemedy.remedyNameUrdu, TextAlign.center, ColorResources.colorBlue, 16, FontWeight.bold),
                                      ),
                                    ),

                                    //region bullet points list
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                                      scrollDirection: Axis.vertical,
                                      itemCount: symptomRemedy.remedyDetails.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        RemedyDetail remedyDetail = symptomRemedy.remedyDetails[index];
                                        return (homeRemedyController.languageEnglish ? remedyDetail.remedyDetailValue.trim() != "" ? true : false : remedyDetail.remedyDetailValueUrdu.trim() != "" ? true : false) ?
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 10.0),
                                          child: bulletListContainer(homeRemedyController.languageEnglish ? remedyDetail.remedyDetailValue : remedyDetail.remedyDetailValueUrdu),
                                        ) : Container();
                                      },
                                    )
                                    //endregion
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
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