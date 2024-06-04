import 'package:courselab_mobile/screens/detail_category.dart';
import 'package:flutter/material.dart';
import 'package:courselab_mobile/widgets/category_tile.dart';
import 'package:courselab_mobile/models/category_model.dart';

class CategoriesList extends StatelessWidget {
  final List<CategoryModel> categories;
  final String errorMessage;

  const CategoriesList(
      {Key? key, required this.categories, this.errorMessage = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => CategoryTile(
        category: categories[index],
        onTap: () => _onCategoryTap(context, categories[index]),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 11),
      itemCount: categories.length,
    );
  }

  void _onCategoryTap(BuildContext context, CategoryModel category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailCategoryPage(categoryId: category.id),
      ),
    );
  }
}
