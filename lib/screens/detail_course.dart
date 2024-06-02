import 'package:courselab_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class CourseDetailPage extends StatefulWidget {
  final int courseId;

  const CourseDetailPage({Key? key, required this.courseId}) : super(key: key);

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  dynamic course;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCourseDetails();
  }

  Future<void> fetchCourseDetails() async {
    try {
      var fetchedCourse = await ApiService.fetchCourseDetails(widget.courseId);
      setState(() {
        course = fetchedCourse;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6366F1),
        title: Text(
            isLoading ? 'Loading...' : course?['title'] ?? 'Course Detail',
            style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : buildCourseContent(),
    );
  }

  Widget buildCourseContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (course != null) ...[
              Text(course['title'] ?? "No title available",
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              course['image'] != null
                  ? Image.network('$baseUrl/storage/${course['image']}')
                  : const Text("No image available"),
              const SizedBox(height: 20),
              HtmlWidget(course['content'] ?? "No description available"),
            ] else ...[
              const Text("No course data available.")
            ]
          ],
        ),
      ),
    );
  }
}
