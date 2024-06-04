import 'package:courselab_mobile/models/forum_model.dart';
import 'package:courselab_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ForumDetailPage extends StatefulWidget {
  final int forumId;

  const ForumDetailPage({Key? key, required this.forumId}) : super(key: key);

  @override
  _ForumDetailPageState createState() => _ForumDetailPageState();
}

class _ForumDetailPageState extends State<ForumDetailPage> {
  Forum? forum;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchForumDetails();
  }

  Future<void> fetchForumDetails() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/api/forum/${widget.forumId}'));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData['data']);
        if (responseData['data'] != null) {
          setState(() {
            forum = Forum.fromJson(responseData['data']);
            isLoading = false;
          });
        } else {
          throw Exception('No data available in response');
        }
      } else {
        throw Exception(
            'Failed to load forum details with status code ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching forum details: $e');
      print(
          'Stack Trace: $stackTrace'); // This will help identify where exactly in the code the error occurs
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(forum?.title ?? "Loading...")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : forum == null
              ? const Center(child: Text("Failed to load forum details"))
              : buildForumDetails(forum!),
    );
  }

  Widget buildForumDetails(Forum forum) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(forum.title.toString(),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(
                'Posted by ${forum.user?.name.toString()} on ${forum.createdAt?.toIso8601String()}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(forum.body.toString(), style: const TextStyle(fontSize: 16)),
            // Handle posts
            ...forum.posts!.map((post) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.body.toString()),
                  Text(
                      'Posted by ${post.user?.name.toString()} on ${post.createdAt?.toIso8601String()}'),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
