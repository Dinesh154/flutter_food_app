import 'package:ecommerce_app/view/widgets/cart/customRow.dart';
import 'package:ecommerce_app/view/widgets/cart/mySeparator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/theme.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.total,
  }) : super(key: key);
  final int total;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.grey.withOpacity(.3),
      child: Column(
        children: [
           
          //MySeparator(color: Colors.grey),
          CustomRow(
            FontWeight.bold,
            mainColor,
            name: 'Total Price'.tr,
            price: 'Rs.${total}',
            color: mainColor,
          ),
        ],
      ),
    );
  }
}
