import 'dart:math' as math;

import 'package:ecommerce_app/logic/controllers/all_recipe_controller.dart';
import 'package:ecommerce_app/routes/routes.dart';
import 'package:ecommerce_app/services/helper/handlingdataview.dart';
import 'package:ecommerce_app/view/screens/product_details_scree.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../logic/controllers/home_controllers.dart';
import '../../logic/controllers/onboarding_home_controller.dart';

import '../../utils/sharPreferenceUtils .dart';
import '../../utils/theme.dart';
import '../widgets/home/appbarItem.dart';
import '../widgets/home/customRowHomePage.dart';
import '../widgets/home/foodsView.dart';
import '../widgets/home/onbordingItem.dart';
import '../widgets/home/resturantCard.dart';
import '../widgets/onboarding/onBoardingIndicator_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final controller = Get.put(OnBoardingHomeController());
  final homeController = Get.put(All_recipe_controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<All_recipe_controller>(
            init: All_recipe_controller(),
            initState: (_) {
              homeController.fetchAll_recipe();
            },
            builder: (controller) {
              return SingleChildScrollView(
                //physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                   //mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarItem(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Chillies Restaurant",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // CircularProgressIndicator.adaptive(),
                    ResturantCard(),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomRowHomePage(
                        firstText: 'Popular foods'.tr,
                        scoindText: 'More'.tr,
                        press: () {
                          Get.toNamed(Routes.allFoodScreen);
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 300.h,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.all_recipe.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(()=>
                                  ProductDetailsScreen(controller: controller.all_recipe[index]),
                                  arguments:controller.all_recipe[index]
                                );
                              },
                              child: FoodsView(
                                homeProdectData:
                                    controller.all_recipe.value[index],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            }));
  }

  // Container FodeShow() {
  //   return Container(
  //     height: 200,
  //     width: double.infinity,
  //     padding: const EdgeInsets.only(left: 2),
  //     child: ListView.builder(
  //         physics: const BouncingScrollPhysics(),
  //         itemCount: homeController.homeFoodsList.length,
  //         shrinkWrap: true,
  //         scrollDirection: Axis.horizontal,
  //         itemBuilder: (context, index) {
  //           return GestureDetector(
  //             onTap: () {
  //               Get.toNamed(
  //                 Routes.productDetailsScreen,
  //                 arguments: [
  //                   {'prodectData': homeController.homeFoodsList[index]}
  //                 ],
  //               );
  //             },
  //             child: FoodsView(
  //               homeProdectData:  controller.a[index],
  //             ),
  //           );
  //         }),
  //   );
  // }

//   SizedBox ResturantShow() {
//     return SizedBox(
//       height: 100,
//       child: Padding(
//         padding: EdgeInsets.only(left: 12.w),
//         child: ListView.builder(
//           physics: const BouncingScrollPhysics(),
//           scrollDirection: Axis.horizontal,
//           shrinkWrap: true,
//           itemCount: homeController.homeRestaurantsList.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 Get.toNamed(Routes.resturantScreen, arguments: [
//                   {
//                     "id":
//                         homeController.homeRestaurantsList[index].id.toString(),
//                   }
//                 ]);
//               },
//               child: ResturantCard(),
//             );
//           },
//         ),
//       ),
//     );
//   }
}
