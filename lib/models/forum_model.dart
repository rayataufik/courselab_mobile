import 'package:courselab_mobile/models/post_model.dart';
import 'package:courselab_mobile/models/user_model.dart';

class Forum {
  int? id;
  int? userId;
  String? title;
  String? slug;
  String? body;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  List<PostElement>? posts;

  Forum({
    this.id,
    this.userId,
    this.title,
    this.slug,
    this.body,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.posts,
  });

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        slug: json["slug"],
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        posts: json["posts"] != null
            ? List<PostElement>.from(
                json["posts"].map((x) => PostElement.fromJson(x)))
            : [], // Handle null posts
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "slug": slug,
        "body": body,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "posts": posts != null
            ? List<dynamic>.from(posts!.map((x) => x.toJson()))
            : [],
      };
}
