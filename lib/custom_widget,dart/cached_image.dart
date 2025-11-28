import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImage extends StatelessWidget {
  String? imageUrl;
  CachedImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.all(Radius.circular(15)),
      child: CachedNetworkImage(
        imageUrl:
            imageUrl ??
            'http://startflutter.ir/api/files/equwrpwnez9pvim/qnbj8d6b9lzzpn8/rectangle_63_OHpTjZfdL4.png',
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(color: Colors.grey),
        errorWidget: (context, url, error) => Container(
          color: Colors.red,
          child: Center(child: Icon(Icons.error)),
        ),
      ),
    );
  }
}
