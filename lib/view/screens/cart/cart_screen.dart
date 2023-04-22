import 'package:ecommerce_app/routes/routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import '../../../logic/controllers/cart_controllers.dart';
import '../../../services/cart_services.dart';
import '../../../utils/sharPreferenceUtils .dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/cart/appBarCart.dart';
import '../../widgets/cart/customCard.dart';
import '../../widgets/cart/listViewItem.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final cartController = Get.put(CartController());
  final _paymentItems = [];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        initState: (state) {
          print('object');
          cartController.fetchAll_cart();
        },
        builder: (_) {
          return Scaffold(
              appBar: AppBarCart(),
              body: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Column(
                    children: [
                      Obx(() => cartController.cartDataList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: cartController.cartDataList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  ListViewItem(
                                cartData: cartController.cartDataList[index],
                              ),
                            )
                          : SizedBox(
                              height: Get.height * .48,
                              child: Center(
                                  child: Text(
                                "No Foods In Cart".tr,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .color!
                                      .withOpacity(.5),
                                ),
                              )),
                            )),
                      SizedBox(
                        height: Get.height * .4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              CustomCard(
                                total: cartController.cart_TotalPrice.value,
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              GooglePayButton(
                                width: 300.w,
                                paymentConfigurationAsset: "gpay.json",
                                paymentItems: [
                                  PaymentItem(
                                    label: 'Total',
                                    amount: '${cartController.cart_TotalPrice}',
                                    status: PaymentItemStatus.final_price,
                                  )
                                ],
                                type: GooglePayButtonType.pay,
                                margin: const EdgeInsets.only(top: 15.0),
                                onPaymentResult: (value) {
                                  print(value);
                                  print("payment sucessfull");
                                },
                                loadingIndicator: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )));
        });
  }
}
