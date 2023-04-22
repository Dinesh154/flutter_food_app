// To parse this JSON data, do
//
//     final cart_model = cart_modelFromJson(jsonString);

import 'dart:convert';

List<cart_model> cart_modelFromJson(String str) => List<cart_model>.from(json.decode(str).map((x) => cart_model.fromJson(x)));

String cart_modelToJson(List<cart_model> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class cart_model {
    cart_model({
        required this.name,
        required this.imageUrl,
        required this.price,
        required this.description,
        required this.rating,
        required this.mainIngredient,
        required this.calories,
        this.quantity,
    });

    String name;
    String imageUrl;
    int price;
    String description;
    double rating;
    String mainIngredient;
    int calories;
    int? quantity;

    factory cart_model.fromJson(Map<String, dynamic> json) => cart_model(
        name: json["name"],
        imageUrl: json["imageUrl"],
        price: json["price"],
        description: json["description"],
        rating: json["rating"]?.toDouble(),
        mainIngredient: json["mainIngredient"],
        calories: json["calories"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "price": price,
        "description": description,
        "rating": rating,
        "mainIngredient": mainIngredient,
        "calories": calories,
        "quantity": quantity,
    };
}
