import 'package:ecommerce_app/model/review/reviewProdect_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../textWithFont.dart';

class CardRev extends StatelessWidget {
  CardRev({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Data data;
  @override
  Widget build(BuildContext context) {

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset('assets/profile.png',
                    height: 90.0.h, width: 90.w),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWithFont().textWithRobotoFont(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.normal,
                      text:' data.user!.id.toString()'),
                  RatingBar.builder(
                    initialRating:4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Color.fromRGBO(245, 201, 99, 1),
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              data.feedback!,
              style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              maxLines: 3,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextWithFont().textWithRalewayFont(
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 16.sp,
                text: data.createdAt!.substring(0, 10),
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
