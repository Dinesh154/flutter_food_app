import 'package:ecommerce_app/logic/controllers/all_recipe_controller.dart';
import 'package:ecommerce_app/utils/theme.dart';
import 'package:ecommerce_app/view/screens/review/allReview_screen.dart';
import 'package:ecommerce_app/view/widgets/auth/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../logic/controllers/cart_controllers.dart';
import '../../logic/controllers/favorites_conntroller.dart';
import '../../logic/controllers/productDetails.dart';
import '../../model/All_recipe.dart';
import '../../routes/routes.dart';
import '../../utils/sharPreferenceUtils .dart';
import '../widgets/productDetails/backIcon.dart';
import '../widgets/productDetails/customTriangle.dart';
import '../widgets/productDetails/description.dart';
import '../widgets/productDetails/descriptionText.dart';
import '../widgets/productDetails/imageShadow.dart';
import '../widgets/productDetails/itemCounter.dart';
import '../widgets/productDetails/ratingBarRev.dart';
import '../widgets/productDetails/reviewProduct.dart';
import '../widgets/productDetails/seeMore.dart';
import '../widgets/productDetails/showImage.dart';
import '../widgets/productDetails/supTitle.dart';
import '../widgets/productDetails/titelText.dart';
import '../widgets/textWithFont.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({
    required this.controller,
  });
  final Allrecipes controller;
  final favoriteController = Get.find<FavoritesController>();
  var productdetails = Get.put(ProductDetailsController());
  final cartController =
      Get.put<All_recipe_controller>(All_recipe_controller());

  // chicke() {
  //   print('done1');

  //   String name = controller.name!;
  //   String image = controller. imageUrl!;

  //   cartController.addProductToCart(
  //     quantity: controller.counter.value,
  //     product_id: controller.prodectData.value.id!,
  //     nameProduct: name,
  //     imageProduct: image,
  //   );

  //   print('done2');
  // }

  // Future<Null> _refreshLocalGallery() async {
  //   controller.viewProdectById(controller.prodectData.value.id!);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Stack(
                children: [
                  ShowImage(
                    imageUrl: controller.imageUrl,
                  ),
                  ImageShadow(),
                ],
              ),
              SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    BackIcon(),
                    SizedBox(
                      height: ScreenUtil().screenHeight * 0.35,
                    ),
                    SizedBox(
                      //height: ScreenUtil().screenHeight * .64,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Container(
                              //height: ScreenUtil().screenHeight * .64,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              decoration: ShapeDecoration(
                                color: Theme.of(context).cardColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitelText(
                                    title: controller.name,
                                  ),
                                  SupTitle(
                                    supTitle: controller.name,
                                    cal: controller.calories.toString(),
                                    price: productdetails.counter.value *
                                        controller.price,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),

                                  ReviewProduct(),

                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        RatingBarRev(
                                          rating: controller.rating.toDouble(),
                                        ),
                                        TextWithFont().textWithRalewayFont(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .color!,
                                            fontSize: 12.sp,
                                            text:
                                                '(${controller.rating}) Review',
                                            fontWeight: FontWeight.w500),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Get.to(()=>
                                                        AllReviewScreen(data: controller,),
                                                         );
                                                  },
                                                  child: SeeMore()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // "Description",
                                  SizedBox(
                                    height: 20.h,
                                  ),

                                  Description(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DescriptionText(
                                    decoration: controller.description,
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Divider(
                                      color: Colors.grey.shade400,
                                      thickness: 1.5,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "${MainIngredient.CHICKEN}",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  ItemCounter(
                                    productDetailsController: productdetails,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  // GetBuilder<CartController>(
                                  //   builder: (_) => Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 20),
                                  //     child: AuthButton(
                                  //       press: SharedPrefs.instance
                                  //                   .getString('token') ==
                                  //               null
                                  //           ? null
                                  //           : () => chicke(),
                                  //       text: 'Add to Cart',
                                  //     ),
                                  //   ),
                                  // )
                                  Center(
                                    child: AuthButton(
                                      text: "Add to Cart",
                                      press: () {
                                        cartController
                                            .add_to_cart(controller.name);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              cartController.add_to_favourite(controller.name);

                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 20,
                              ),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  child: ClipPath(
                                    clipper: CustomTriangle(),
                                    child: Container(
                                        width: 60,
                                        height: 60,
                                        color: Theme.of(context).cardColor,
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: mainColor,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      )
    ]));
  }
}
