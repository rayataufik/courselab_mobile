import 'package:courselab_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:courselab_mobile/models/category_model.dart';
import 'package:courselab_mobile/utils/utils.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback? onTap;

  const CategoryTile({Key? key, required this.category, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 30,
                offset: const Offset(0, 2),
              )
            ]),
        child: Row(children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              '$baseUrl/storage/${category.image}',
              height: 103,
              width: 88,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category.name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 7),
                Text(
                  Utils.stripHtml(category.description),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
