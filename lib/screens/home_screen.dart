import 'package:flutter/material.dart';
import 'package:flutter_shop_sample/constants/colors.dart';
import 'package:flutter_shop_sample/custom_widget,dart/banner_slider.dart';
import 'package:flutter_shop_sample/custom_widget,dart/category_item_chip.dart';
import 'package:flutter_shop_sample/custom_widget,dart/prodouct_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.backgroundScreenColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 44,
                    right: 44,
                    bottom: 32,
                  ),
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Image.asset('assets/images/icon_apple_blue.png'),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.end,
                            'جستجوی محصولات',
                            style: TextStyle(
                              color: CustomColors.gery,
                              fontSize: 16,
                              fontFamily: 'SM',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Image.asset('assets/images/icon_search.png'),
                        SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: BannerSlider()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 44.0,
                    right: 44,
                    bottom: 20,
                    top: 32,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'دسته بندی',
                        style: TextStyle(
                          fontFamily: 'SB',
                          color: CustomColors.gery,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(right: 44.0),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: CategoryItemChip(),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 44,
                    right: 44,
                    bottom: 20,
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/icon_left_categroy.png'),
                      SizedBox(width: 10),
                      Text(
                        'مشاهده همه',
                        style: TextStyle(
                          fontFamily: 'SB',
                          color: CustomColors.blue,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'پرفروش ترین ها',
                        style: TextStyle(
                          fontFamily: 'SB',
                          color: CustomColors.gery,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(right: 44.0),
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: ProdouctItem(),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 44,
                    right: 44,
                    bottom: 20,
                    top: 32,
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/icon_left_categroy.png'),
                      SizedBox(width: 10),
                      Text(
                        'مشاهده همه',
                        style: TextStyle(
                          fontFamily: 'SB',
                          color: CustomColors.blue,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'پر بازدید ترین ها',
                        style: TextStyle(
                          fontFamily: 'SB',
                          color: CustomColors.gery,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(right: 44.0),
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: ProdouctItem(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}

