import 'dart:convert';

List<Allrecipes> AllrecipesFromJson(String str) => List<Allrecipes>.from(json.decode(str).map((x) => Allrecipes.fromJson(x)));

String AllrecipesToJson(List<Allrecipes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Allrecipes {
    Allrecipes({
        required this.id,
        required this.name,
        required this.imageUrl,
        required this.rating,
        required this.mainIngredient,
        required this.price,
        required this.calories,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.reviews,
    });

    String id;
    String name;
    String imageUrl;
    double rating;
    MainIngredient mainIngredient;
    int price;
    int calories;
    String description;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    List<String> reviews;

    factory Allrecipes.fromJson(Map<String, dynamic> json) => Allrecipes(
        id: json["_id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        rating: json["rating"]?.toDouble(),
        mainIngredient: mainIngredientValues.map[json["mainIngredient"]]!,
        price: json["price"],
        calories: json["calories"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        reviews: List<String>.from(json["reviews"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "imageUrl": imageUrl,
        "rating": rating,
        "mainIngredient": mainIngredientValues.reverse[mainIngredient],
        "price": price,
        "calories": calories,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
    };
}

enum MainIngredient { CHICKEN, SALMON, MUTTON }

final mainIngredientValues = EnumValues({
    "Chicken": MainIngredient.CHICKEN,
    "Mutton": MainIngredient.MUTTON,
    "Salmon": MainIngredient.SALMON
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}