import 'package:courselab_mobile/screens/detail_course.dart';
import 'package:courselab_mobile/services/api_service.dart';
import 'package:courselab_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:courselab_mobile/models/detail_category_model.dart';

class DetailCategoryPage extends StatefulWidget {
  final int categoryId;

  const DetailCategoryPage({Key? key, required this.categoryId})
      : super(key: key);

  @override
  _DetailCategoryPageState createState() => _DetailCategoryPageState();
}

class _DetailCategoryPageState extends State<DetailCategoryPage> {
  DetailCategoryModel? detailCategory;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCategoryDetails();
  }

  Future<void> fetchCategoryDetails() async {
    try {
      DetailCategoryModel fetchedDetails =
          await ApiService.fetchCategoryDetails(widget.categoryId);
      setState(() {
        detailCategory = fetchedDetails;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> refreshCategoryDetails() async {
    fetchCategoryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6366F1),
        title: Text(
          detailCategory?.name ?? 'Category Details',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshCategoryDetails,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: buildCategoryDetails(),
                      ),
                    ),
                  ),
      ),
    );
  }

  List<Widget> buildCategoryDetails() {
    List<Widget> widgets = [
      Text(Utils.stripHtml(detailCategory?.description ?? "No Description"),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
    ];

    for (var subcategory in detailCategory?.subcategories ?? []) {
      widgets.add(Text(subcategory.name,
          style: const TextStyle(fontWeight: FontWeight.bold)));
      for (var content in subcategory.contents) {
        widgets.add(Card(
          child: ListTile(
            title: Text(content.title),
            subtitle: Text('Updated at: ${content.updatedAt}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CourseDetailPage(courseId: content.id)),
              );
            },
          ),
        ));
      }
    }
    return widgets;
  }
}
