import 'dart:convert';

import 'package:ecommerce_app/model/All_recipe.dart';
import 'package:ecommerce_app/model/cart/Cart_model.dart';
import 'package:ecommerce_app/model/cart_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/baseAPI.dart';
import '../../services/cart_services.dart';
import '../../utils/sharPreferenceUtils .dart';

class CartController extends GetxController {
  RxList<cart_model> cartDataList = <cart_model>[].obs;
  var storge = SharedPrefs.instance;
  String cartListString = '';
  RxInt cart_TotalPrice = 0.obs;
  RxList quantity_list = [].obs;
  void fetchAll_cart() async {
    print('called');
    try {
      //isLoading(true);
      var all_recipe = await http.get(Uri.parse(
          "http://192.168.27.212:3000/api/getCartItems/kasasunil344@gmail.com"));
      print("request");
      print(all_recipe.statusCode);
      print(all_recipe.body);
      if (all_recipe.statusCode == 200) {
        var all_recipeJson = cart_modelFromJson(all_recipe.body);
        print(all_recipeJson);
        if (all_recipeJson != null) {
          cartDataList.value = all_recipeJson;
          // print(cartDataList.value[0].imageUrl);

          cartTotalPrice();
          update();
        }
      }
    } catch (e) {
      print(e);
    } finally {
      //isLoading(false);
    }
  }

  void cartTotalPrice() {
    cartDataList.forEach((item) {
      int price = item.price;
      print(item.quantity);
      cart_TotalPrice.value += price;
      update();
    });
  }

  void change_quantity(int index) {
    quantity_list[index] += 1;
  }

  void getquantity_list() {
    for (int i = 0; i < cartDataList.length; i++) {
      quantity_list.add(1);
    }
    update();
  }
  // @override
//   void onInit() async {
//     cartListString = storge.getString('cartDataList') ?? '';
//     if (cartListString != '') {
//       final List<CartData> cartList = CartData.decode(cartListString);

//       cartDataList.value = cartList;
//     }
//     super.onInit();
//   }

//   void addProductToCart(
//       {required int quantity,
//       required String product_id,
//       required String nameProduct,
//       required String imageProduct}) async {
//     await CartServices()
//         .addToCart(quantity: quantity, product_id: product_id)
//         .then((value) {
//       cartDataList.add(
//         CartData(
//           id: value.id,
//           orderId: value.orderId,
//           productId: value.orderId,
//           unitPrice: value.unitPrice,
//           quantity: value.quantity,
//           price: value.price,
//           image: imageProduct,
//           name: nameProduct,
//         ),
//       );

//       final String encodedData = CartData.encode(cartDataList);
//       storge.setString('cartDataList', encodedData);
//     });

//     update();
//   }

//   void counterAddProductToCart(CartData cartData) {
//     int quantityUpdate = cartData.quantity! + 1;
//     CartData cartUpdate = CartData(
//       id: cartData.id,
//       orderId: cartData.orderId,
//       productId: cartData.orderId,
//       unitPrice: cartData.unitPrice,
//       quantity: quantityUpdate,
//       price: cartData.price,
//       image: cartData.image,
//       name: cartData.name,
//     );
//     cartDataList.indexOf(cartData);
//     cartDataList[cartDataList
//         .indexWhere((element) => element.id == cartData.id)] = cartUpdate;

//     final String encodedData = CartData.encode(cartDataList);
//     storge.setString('cartDataList', encodedData);
//     update();
//   }

//   void counterRemoveProductToCart(CartData cartData) {
//     int quantityUpdate = cartData.quantity! + -1;
//     CartData cartUpdate = CartData(
//       id: cartData.id,
//       orderId: cartData.orderId,
//       productId: cartData.orderId,
//       unitPrice: cartData.unitPrice,
//       quantity: quantityUpdate,
//       price: cartData.price,
//       image: cartData.image,
//       name: cartData.name,
//     );
//     cartDataList.indexOf(cartData);
//     cartDataList[cartDataList
//         .indexWhere((element) => element.id == cartData.id)] = cartUpdate;

//     final String encodedData = CartData.encode(cartDataList);
//     storge.setString('cartDataList', encodedData);
//     update();
//   }

//   void checkOutCart({required List<CartData> cartData}) async {
//     await CartServices().checkOutCart(cartData: cartData);
//   }

//   void deleteFromCart({required int idOrder}) async {
//     await CartServices().deleteFromCart(order_id: idOrder);

//     cartDataList
//         .removeAt(cartDataList.indexWhere((element) => element.id == idOrder));
//     final String encodedData = CartData.encode(cartDataList);
//     storge.setString('cartDataList', encodedData);
//     print('de Done');
//     update();
//   }
// }
//   double totalPriceSum(int order_id) {
//   return ItemsPrice.where((item) => item.todoListId == todoListId)
//                    .fold(0.0, (sum, item) => sum + item['price']);
// }

  // var productsMap = {}.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // void addProductToCart(HomeProdectData productModels) {
  //   if (productsMap.containsKey(productModels)) {
  //     productsMap[productModels] += 1;

  //     print(productsMap[productModels]);
  //   } else {
  //     productsMap[productModels] = 1;
  //     print(productsMap[productModels]);
  //   }
  // }

  // void addProductToCartCounter(HomeProdectData productModels, int counter) {
  //   if (productsMap.containsKey(productModels)) {
  //     productsMap[productModels] += counter;

  //     print(productsMap[productModels]);
  //   } else {
  //     productsMap[productModels] = counter;

  //     print(productsMap[productModels]);
  //   }
  // }

  // void removeProductsFarmCart(HomeProdectData productModels) {
  //   if (productsMap.containsKey(productModels) &&
  //       productsMap[productModels] == 1) {
  //     productsMap.removeWhere((key, value) => key == productModels);
  //   } else {
  //     productsMap[productModels] -= 1;
  //   }
  // }

  // void removeOneProduct(HomeProdectData productModels) {
  //   productsMap.removeWhere((key, value) => key == productModels);
  // }

  // get productSubTotal =>
  //     productsMap.entries.map((e) => e.key.price * e.value).toList();

  // get total => productsMap.entries
  //     .map((e) => e.key.price * e.value)
  //     .toList()
  //     .reduce((value, element) => value + element)
  //     .toStringAsFixed(2);

  // int quantity() {
  //   if (productsMap.isEmpty) {
  //     return 0;
  //   } else {
  //     return productsMap.entries
  //         .map((e) => e.value)
  //         .toList()
  //         .reduce((value, element) => value + element);
  //   }
}
