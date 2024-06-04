import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:courselab_mobile/widgets/categories_list.dart';
import 'package:courselab_mobile/widgets/search_bar.dart' as custom;
import 'package:courselab_mobile/widgets/banner.dart';
import 'package:courselab_mobile/widgets/app_bar.dart';
import 'package:courselab_mobile/services/api_service.dart';
import 'package:courselab_mobile/models/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categories = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      List<CategoryModel> fetchedCategories =
          await ApiService.fetchCategories();
      setState(() {
        categories = fetchedCategories;
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : RefreshIndicator(
                    onRefresh: fetchCategories,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 21),
                          const CustomAppBar(),
                          const SizedBox(height: 17),
                          const PromotionalBanner(),
                          const SizedBox(height: 21),
                          const custom.SearchBar(),
                          const SizedBox(height: 21),
                          CategoriesList(
                              categories: categories,
                              errorMessage: errorMessage),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
