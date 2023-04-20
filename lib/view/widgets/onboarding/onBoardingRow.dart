import 'package:ecommerce_app/logic/controllers/all_recipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../logic/controllers/onboarding_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/theme.dart';
import '../textWithFont.dart';

var _controller = Get.put(All_recipe_controller());

class OnBoardingRow extends StatelessWidget {
  const OnBoardingRow({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final OnBoardingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
               Get.offAndToNamed(Routes.mainScreen);
              //_controller.fetchAll_recipe();
            },
            child: TextWithFont().textWithRobotoFont(
              text: 'Skip'.tr,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: onBoardingSkipButtonColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () {
                controller.next();
              },
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.orange.withOpacity(.07),
                child: TextWithFont().textWithNunitoSansFont(
                  text: 'Next'.tr,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color: mainColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
