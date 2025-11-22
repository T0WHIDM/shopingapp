import 'package:flutter/material.dart';

class CategoryItemChip extends StatelessWidget {
  const CategoryItemChip({super.key});

  @override
  Widget build(BuildContext context) {
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
                color: Colors.amberAccent,
                shadows: [
                  BoxShadow(
                    blurRadius: 25,
                    spreadRadius: -13,
                    color: Colors.amberAccent,
                    offset: Offset(0.0, 15),
                  ),
                ],
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            Icon(Icons.mouse, color: Colors.white, size: 26),
          ],
        ),
        SizedBox(height: 10),
        Text('همه', style: TextStyle(fontFamily: 'SB', fontSize: 12)),
      ],
    );
  }
}
