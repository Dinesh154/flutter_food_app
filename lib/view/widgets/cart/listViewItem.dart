import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/model/All_recipe.dart';
import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/view/widgets/cart/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../logic/controllers/cart_controllers.dart';
import '../../../model/cart/Cart_model.dart';
import '../../../model/homeProdect/homeProdectData.dart';
import '../../../utils/theme.dart';

class ListViewItem extends StatelessWidget {
  ListViewItem({
    Key? key,
    required this.cartData,
  });

  final cart_model cartData;
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 5,
      shadowColor: Colors.grey.withOpacity(.3),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 34.r,
                child: ClipOval(
                  child: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.photo_rounded,
                      color: Colors.grey.shade700,
                      size: 100,
                    ),
                    height: 75.0.h,
                    width: 75.w,
                    fit: BoxFit.cover,
                    imageUrl: cartData.imageUrl,
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartData.name.length > 20
                        ? cartData.name.substring(0, 10) + '...'
                        : cartData.name,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.headline1!.color),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    // ignore: unnecessary_null_comparison
                    'Rs ${cartData.price*(cartData.quantity==null?1:cartData.quantity)!}',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: mainColor),
                  )
                ],
              ),
            ],
          ),
        ),
        trailing: Container(
          width: 75.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: GetBuilder<CartController>(
                  // no need to initialize Controller ever again, just mention the type
                  builder: (value) => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Counter(
                        text: '-',
                        onPressed: () {
                          //cartController.counterRemoveProductToCart(cartData);
                        },
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        '${cartData.quantity==null?1:cartData.quantity}',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.headline1!.color),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Counter(
                        text: '+',
                        onPressed: () {
                          //cartController.counterAddProductToCart(cartData);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
