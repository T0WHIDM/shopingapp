import 'package:flutter/material.dart';
import 'package:flutter_shop_sample/Data/model/banner.dart';
import 'package:flutter_shop_sample/constants/colors.dart';
import 'package:flutter_shop_sample/custom_widget,dart/cached_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final List<MyBanner> bannerList;

  const BannerSlider({super.key, required this.bannerList});

  @override
  Widget build(BuildContext context) {
    var controller = PageController(viewportFraction: 0.9);

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          child: PageView.builder(
            controller: controller,
            itemCount: bannerList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 6),
                child: CachedImage(imageUrl: bannerList[index].thumbnail!),
              );
            },
          ),
        ),
        Positioned(
          bottom: 10,
          child: SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: const ExpandingDotsEffect(
              dotHeight: 6,
              dotWidth: 6,
              expansionFactor: 4,
              dotColor: Colors.white,
              activeDotColor: CustomColors.blueIndicator,
            ),
          ),
        ),
      ],
    );
  }
}
