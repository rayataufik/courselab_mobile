import 'package:courselab_mobile/models/content_model.dart';

class Subcategory {
  final int id;
  final int categoryId;
  final String name;
  final String slug;
  final String createdAt;
  final String updatedAt;
  final List<Content> contents;

  Subcategory({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.contents,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    var contentsList = json['contents'] as List;
    List<Content> contents =
        contentsList.map((i) => Content.fromJson(i)).toList();

    return Subcategory(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      slug: json['slug'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      contents: contents,
    );
  }
}
