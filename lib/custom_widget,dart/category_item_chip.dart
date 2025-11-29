import 'package:flutter/material.dart';
import 'package:flutter_shop_sample/Data/model/category.dart';
import 'package:flutter_shop_sample/custom_widget,dart/cached_image.dart';

class CategoryItemChip extends StatelessWidget {
  final Category category;

  const CategoryItemChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    String categoryColor = 'FFF${category.color}';
    int hexColor = int.parse(categoryColor, radix: 16);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: ShapeDecoration(
                color: Color(hexColor),
                shadows: [
                  BoxShadow(
                    blurRadius: 25,
                    spreadRadius: -13,
                    color: Color(hexColor),
                    offset: Offset(0.0, 15),
                  ),
                ],
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            SizedBox(
              height: 24,
              width: 24,
              child: CachedImage(imageUrl: category.icon),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          category.title ?? 'محصول',
          style: TextStyle(fontFamily: 'SB', fontSize: 12),
        ),
      ],
    );
  }
}
