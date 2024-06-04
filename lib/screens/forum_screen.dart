import 'dart:convert';
import 'package:courselab_mobile/models/forum_model.dart';
import 'package:courselab_mobile/screens/detail_forum_screen.dart';
import 'package:courselab_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  List<Forum> threads = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchForums();
  }

  Future<void> fetchForums() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/forum'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = json.decode(response.body);

        if (responseJson['success']) {
          List<dynamic> forumsJson =
              responseJson['data'] as List<dynamic>; // Safely cast as List
          List<Forum> forums =
              forumsJson.map((json) => Forum.fromJson(json)).toList();

          setState(() {
            threads = forums;
            isLoading = false;
          });
        } else {
          throw Exception(
              'Failed to load forums: API returned false for success');
        }
      } else {
        throw Exception(
            'Failed to load forums with status code ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Forum"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: threads.length,
                itemBuilder: (context, index) {
                  Forum thread = threads[index];
                  return Card(
                    child: ListTile(
                      title: Text(thread.title ?? ''),
                      subtitle: Text(
                          "${thread.body ?? ''}\nPosted by ${thread.user?.name ?? 'Unknown'} - ${thread.createdAt ?? ''}"),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ForumDetailPage(forumId: thread.id!.toInt()),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
