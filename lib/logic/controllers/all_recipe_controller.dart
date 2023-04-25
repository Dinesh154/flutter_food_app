import 'dart:convert';

import 'package:ecommerce_app/model/All_recipe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class All_recipe_controller extends GetxController {
  RxList<Allrecipes> all_recipe = <Allrecipes>[].obs;
  var isLoading = true.obs;

  void fetchAll_recipe() async {
    print('object');
    try {
      isLoading(true);
      var all_recipe = await http
          .get(Uri.parse("http://192.168.27.212:3000/api/allRecipes"));
      print("request");
      print(all_recipe.statusCode);

      if (all_recipe.statusCode == 200) {
        var all_recipeJson = AllrecipesFromJson(all_recipe.body);
        print(all_recipeJson);
        if (all_recipeJson != null) {
          this.all_recipe.value = all_recipeJson;
          print(this.all_recipe.value[0].imageUrl);
        }
      }
      update();
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  void add_to_cart(String recipe) async {
    try {
      var response = await http.post(
          Uri.parse("http://192.168.27.212:3000/api/addToCart"),
          body:
              jsonEncode({"recipe": recipe, "email": "kasasunil344@gmail.com"}),
          headers: {"Content-type": "application/json"});
      Get.snackbar("Added to the Cart Succesfully!", "",
          snackPosition: SnackPosition.BOTTOM);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.back();
      }
    } catch (e) {
      print(e);
    }
  }

  void add_to_favourite(String recipe) async {
    try {
      var response = await http.post(
          Uri.parse("http://192.168.27.212:3000/api/addToFavorite"),
          body:
              jsonEncode({"recipe": recipe, "email": "kasasunil344@gmail.com"}),
          headers: {"Content-type": "application/json"});
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar("Added to the favourites Succesfully!", "",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }

  void get_cartItems() async {
    print('object');
    try {
      isLoading(true);
      var all_recipe = await http.get(Uri.parse(
          "http://192.168.27.212:3000/api/getCartItems/kasasunil344@gmail.com"));
      print("request");
      print(all_recipe.statusCode);
      if (all_recipe.statusCode == 200) {
        var all_recipeJson = AllrecipesFromJson(all_recipe.body);
        print(all_recipeJson);
        if (all_recipeJson != null) {
          this.all_recipe.value = all_recipeJson;
          print(this.all_recipe.value[0].imageUrl);
        }
      }
      update();
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
