import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/homeRestaurant/homeRestaurantData.dart';

class ResturantCard extends StatelessWidget {
  const ResturantCard({
    Key? key,
    //required this.homeRestaurantsData,
  }) : super(key: key);
  //final HomeRestaurantsData homeRestaurantsData;
  @override
  Widget build(BuildContext context) {
    
    return  Center(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),

        ),
        child: Image.asset("assets/resturant.png",
        width: 350.w,
        fit: BoxFit.cover,
        ),
      ),
    );
  }
}
