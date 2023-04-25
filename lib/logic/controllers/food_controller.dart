import 'dart:ffi';

import 'package:ecommerce_app/logic/controllers/home_controllers.dart';
import 'package:ecommerce_app/model/All_recipe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../enums/loading_state.dart';
import '../../enums/loading_types.dart';
import '../../model/allCategories.dart';
import '../../model/homeProdect/homeProdectData.dart';
import '../../model/prodect/productDetails_modle.dart';
import '../../services/food_services.dart';
import '../../services/helper/statusrequest.dart';

class FodeController extends GetxController {
  var allFoodsList = <Allrecipes>[].obs;
  var allCategoriesList = <Data>[].obs;
  var homecontroller = HomeController();
  final isLoading = true.obs;
  final scrollController = ScrollController();
  int _pageNo = 1;
  final loadingState = LoadingState(loadingType: LoadingType.stable).obs;
  late StatusRequest statusRequestFood;
  var currentSeletected = 0.obs;
  var currentSeletectedRating = 0.obs;
  var currentSeletectedSlider = 0.0.obs;
  Rx<RangeValues> values = RangeValues(0, 100.00).obs;
  RxString startLabel = 0.toString().obs;
  RxString endLabel = 100.00.toString().obs;

  final List sizeList = [
    1,
    2,
    3,
    4,
    5,
  ].obs;

  @override
  void onInit() async {
    //await viewAllFood();
    await fetchAll_recipe();
    await viewCategories();
    scrollController.addListener(_scrollListener);
  }

   fetchAll_recipe() async {
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
          this.allFoodsList.value = all_recipeJson;
          print(this.allFoodsList.value[0].imageUrl);
        }
      }
      update();
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  void _scrollListener() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      print('donw');
      loadingState.value = LoadingState(loadingType: LoadingType.loading);
      try {
        await Future.delayed(Duration(seconds: 5));

        final listOfData = await FoodApi.viewAllFoods(++_pageNo);

        if (allFoodsList.isEmpty) {
          loadingState.value = LoadingState(
              loadingType: LoadingType.completed,
              completed: "there is no data");
        } else {
          //allFoodsList.addAll(listOfData);
          loadingState.value = LoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value =
            LoadingState(loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  // Future<void> viewAllFood() async {
  //   homeController.fetchAll_recipe();
  //   allFoodsList.assignAll(listOfData);
  //   isLoading.value = false;
  // }

  viewCategories() async {
    var response = await FoodApi.viewAllCategories();

    if (response['status'] == 200) {
      final dataList =
          (response['data'] as List).map((e) => Data.fromJson(e)).toList();
      print(dataList);
      allCategoriesList.addAll(dataList);
    }

    update();
  }

  filterProdect(
      {required String category,
      required int price,
      required int rating,
      required String subcategory}) async {
    var response = await FoodApi.filterProdect(
        category: category,
        price: price,
        rating: rating,
        subcategory: subcategory);

    if (response['status'] == 200) {
      final dataList =
          (response['data'] as List).map((e) => Data.fromJson(e)).toList();
      print(dataList);
      allCategoriesList.assignAll(dataList);
    }

    update();
  }
}
