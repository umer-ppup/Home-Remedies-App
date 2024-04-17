// import 'dart:async';
//
// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:home_remedies/common_controller/home_remedy_controller.dart';
// import 'package:home_remedies/models/response/home_remedy_model.dart';
// import 'package:home_remedies/shared/constants/color_resources.dart';
// import 'package:home_remedies/shared/constants/image_resources.dart';
// import 'package:home_remedies/shared/constants/string_resources.dart';
// import 'package:home_remedies/shared/util/util.dart';
// import 'package:home_remedies/widget/custom_widget.dart';
//
// class CategoriesScreen extends StatefulWidget {
//   const CategoriesScreen({Key? key}) : super(key: key);
//
//   @override
//   _CategoriesScreenState createState() => _CategoriesScreenState();
// }
//
// class _CategoriesScreenState extends State<CategoriesScreen> {
//   DateTime? currentBackPressTime;
//   late HomeRemedyController homeRemedyController;
//
//   Future<void> pullRefresh() async {
//     homeRemedyController.fetchHomeRemedies();
//   }
//
//   Future<bool> onWillPop() {
//     DateTime now = DateTime.now();
//     if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
//       currentBackPressTime = now;
//       myToast("press_again_to_exit".tr);
//       return Future.value(false);
//     }
//     return Future.value(true);
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     try{
//       homeRemedyController = Get.find();
//       homeRemedyController.fetchHomeRemedies();
//     }catch(exception){
//       homeRemedyController = Get.put(HomeRemedyController());
//       homeRemedyController.fetchHomeRemedies();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: onWillPop,
//       child: StreamBuilder(
//         stream: Connectivity().onConnectivityChanged,
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
//           var result = snapshot.data;
//           switch (result) {
//             case ConnectivityResult.none:
//               break;
//             case ConnectivityResult.mobile:
//             case ConnectivityResult.wifi:
//               Timer(Duration(seconds: 5), () {
//                 if(homeRemedyController.homeRemediesList.isEmpty && !homeRemedyController.isLoading){
//                   homeRemedyController.fetchHomeRemedies();
//                 }
//               });
//               break;
//             default:
//               break;
//           }
//           return myBody();
//         },
//       ),
//     );
//   }
//
//   //region Body Widget
//   Widget myBody(){
//     return GetBuilder<HomeRemedyController>(
//         builder: (_) =>  Scaffold(
//           backgroundColor: ColorResources.whiteColor,
//           body: SafeArea(
//             child: Container(
//               width: double.infinity,
//               height: double.infinity,
//               child: Stack(
//                 children: [
//                   //region clip container code
//                   ClipPath(
//                     clipper: CustomClipPath(),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       color: ColorResources.colorBlue,
//                       height: 200.0,
//                     ),
//                   ),
//                   //endregion
//
//                   //region search widget
//                   Positioned(
//                     top: 5.0,
//                     right: 5.0,
//                     child: MaterialButton(
//                       onPressed: () async {
//                         if(StringResources.data.isNotEmpty){
//                           await showLoading();
//                           showSearch(context: context, delegate: MySearchModel());
//                           await hideLoading();
//                         }
//                         else{
//                           myToast("We don't have data.");
//                         }
//                       },
//                       minWidth: 0,
//                       color: ColorResources.whiteColor,
//                       textColor: ColorResources.whiteColor,
//                       child: Icon(
//                         Icons.search,
//                         size: 24,
//                         color: ColorResources.colorBlue,
//                       ),
//                       padding: EdgeInsets.all(8),
//                       shape: CircleBorder(),
//                     ),
//                   ),
//                   //endregion
//
//                   Column(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(top: 50.0),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                                 child: myText("home_remedies".tr, TextAlign.center, ColorResources.whiteColor, 28, FontWeight.bold),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 70.0,
//                       ),
//                       //region top text and list
//                       Expanded(
//                         child: Container(
//                           child: RefreshIndicator(
//                             color: ColorResources.colorBlue,
//                             backgroundColor: ColorResources.whiteColor,
//                             onRefresh: pullRefresh,
//                             child: SingleChildScrollView(
//                               physics: AlwaysScrollableScrollPhysics(),
//                               child: Center(
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     homeRemedyController.isLoading == true ? Container(
//                                       child: Center(
//                                         child: CircularProgressIndicator(
//                                           valueColor: new AlwaysStoppedAnimation<Color>(ColorResources.colorBlue),
//                                         ),
//                                       ),
//                                     ) : homeRemedyController.homeRemediesList.isEmpty && !homeRemedyController.isLoading ?
//                                     Container(
//                                       child: Center(
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             Container(
//                                               width: double.infinity,
//                                               clipBehavior: Clip.antiAlias,
//                                               margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.only(
//                                                   topLeft: Radius.circular(100.0),
//                                                   bottomLeft: Radius.circular(100.0),
//                                                   bottomRight: Radius.circular(0.0),
//                                                   topRight: Radius.circular(100.0),
//                                                 ),
//                                                 color: ColorResources.whiteColor,
//                                               ),
//                                               child: Image.asset(
//                                                 ImageResources.no_data_found,
//                                                 fit: BoxFit.contain,
//                                               ),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Expanded(
//                                                   child: Container(
//                                                     margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//                                                     padding: EdgeInsets.symmetric(horizontal: 20.0),
//                                                     child: myText("Sorry! No data found.", TextAlign.center, ColorResources.colorBlue, 16.0, FontWeight.bold),
//                                                   ),
//                                                 ),
//                                                 Container(
//                                                   margin: EdgeInsets.only(right: 10.0),
//                                                   child: TextButton(
//                                                     style: ButtonStyle(
//                                                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                                           RoundedRectangleBorder(
//                                                               borderRadius: BorderRadius.circular(10.0)
//                                                           )
//                                                       ),
//                                                       backgroundColor: MaterialStateProperty.all(ColorResources.colorBlue),
//                                                       overlayColor: MaterialStateProperty.all(ColorResources.colorBlueLight),
//                                                       animationDuration: Duration(milliseconds: 3, microseconds: 0),
//                                                     ),
//                                                     onPressed: () {
//                                                       homeRemedyController.fetchHomeRemedies();
//                                                     },
//                                                     child: myText("Re-Try", TextAlign.center, ColorResources.whiteColor, 16.0, FontWeight.bold),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ) :
//                                     Container(
//                                       child: GridView.builder(
//                                           physics: NeverScrollableScrollPhysics(),
//                                           padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
//                                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 2,
//                                             crossAxisSpacing: 20,
//                                             mainAxisSpacing: 20,
//                                             childAspectRatio: 1/0.8,
//                                           ),
//                                           shrinkWrap: true,
//                                           itemCount: homeRemedyController.homeRemediesList.length,
//                                           itemBuilder: (buildContext, index) {
//                                             HomeRemediesModel homeRemedyModel = homeRemedyController.homeRemediesList[index];
//                                             return InkWell(
//                                               onTap: () {
//                                                 homeRemedyController.selectCategories(context, index);
//                                               },
//                                               child: Container(
//                                                 clipBehavior: Clip.antiAlias,
//                                                 decoration: BoxDecoration(
//                                                   boxShadow: [BoxShadow(
//                                                     color: ColorResources.darkGreyColor.withOpacity(0.2),
//                                                     spreadRadius: 1,
//                                                     blurRadius: 3,
//                                                     offset: Offset(0, 0),
//                                                   )],
//                                                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                                   color: ColorResources.whiteColor,
//                                                 ),
//                                                 child: Column(
//                                                   mainAxisSize: MainAxisSize.max,
//                                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                                   children: [
//                                                     Container(
//                                                       width: 50.0,
//                                                       height: 50.0,
//                                                       child: SvgPicture.asset(
//                                                         ImageResources.diseaseIcon,
//                                                         semanticsLabel: 'Diseases',
//                                                         fit: BoxFit.contain,
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       padding: EdgeInsets.symmetric(horizontal: 10.0),
//                                                       child: myTextWidgetMaxLine(homeRemedyModel.categoryName, TextAlign.center, ColorResources.colorBlue, 16, FontWeight.bold, 3),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             );
//                                           }),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                       //endregion
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         )
//     );
//   }
//   //endregion
// }
