import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  List<Category> category;

  CategoryModel({
    required this.category,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
      };
}

class Category {
  String name;
  List<String> subCategory;

  Category({
    required this.name,
    required this.subCategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subCategory: List<String>.from(json["subCategory"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "subCategory": List<dynamic>.from(subCategory.map((x) => x)),
      };
}
