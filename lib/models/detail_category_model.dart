import 'package:courselab_mobile/models/subcategory_model.dart'; // Assuming this exists and is set up properly

class DetailCategoryModel {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String image;
  final String createdAt;
  final String updatedAt;
  final List<Subcategory> subcategories;

  DetailCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.subcategories,
  });

  factory DetailCategoryModel.fromJson(Map<String, dynamic> json) {
    var subcategoriesList = json['subcategories'] as List;
    List<Subcategory> subcategories =
        subcategoriesList.map((i) => Subcategory.fromJson(i)).toList();

    return DetailCategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      subcategories: subcategories,
    );
  }
}
