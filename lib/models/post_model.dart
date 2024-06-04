import 'package:courselab_mobile/models/user_model.dart';

// class Post {
//   final int id;
//   final int threadId;
//   final int userId;
//   final String body;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final User? user;  // Making User nullable if API might not always provide it

//   Post({
//     required this.id,
//     required this.threadId,
//     required this.userId,
//     required this.body,
//     required this.createdAt,
//     required this.updatedAt,
//     this.user,  // User is optional
//   });

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       id: json['id'],
//       threadId: json['thread_id'],
//       userId: json['user_id'],
//       body: json['body'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       user: json['user'] != null ? User.fromJson(json['user']) : null,  // Check for null before parsing
//     );
//   }
// }

class PostElement {
  int? id;
  int? threadId;
  int? userId;
  String? body;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  PostElement({
    this.id,
    this.threadId,
    this.userId,
    this.body,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory PostElement.fromJson(Map<String, dynamic> json) => PostElement(
        id: json["id"],
        threadId: json["thread_id"],
        userId: json["user_id"],
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thread_id": threadId,
        "user_id": userId,
        "body": body,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}
