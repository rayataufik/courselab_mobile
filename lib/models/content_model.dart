class Content {
  final int id;
  final int subcategoryId;
  final String title;
  final String slug;
  final String image;
  final String content;
  final String createdAt;
  final String updatedAt;

  Content({
    required this.id,
    required this.subcategoryId,
    required this.title,
    required this.slug,
    required this.image,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'],
      subcategoryId: json['subcategory_id'],
      title: json['title'],
      slug: json['slug'],
      image: json['image'],
      content: json['content'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
