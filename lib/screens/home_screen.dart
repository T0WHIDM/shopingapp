import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_sample/Data/model/banner.dart';
import 'package:flutter_shop_sample/Data/model/category.dart';
import 'package:flutter_shop_sample/Data/model/product.dart';
import 'package:flutter_shop_sample/bloc/home/home_bloc.dart';
import 'package:flutter_shop_sample/bloc/home/home_event.dart';
import 'package:flutter_shop_sample/bloc/home/home_state.dart';
import 'package:flutter_shop_sample/constants/colors.dart';
import 'package:flutter_shop_sample/custom_widget,dart/banner_slider.dart';
import 'package:flutter_shop_sample/custom_widget,dart/category_item_chip.dart';
import 'package:flutter_shop_sample/custom_widget,dart/loading_animaation.dart';
import 'package:flutter_shop_sample/custom_widget,dart/prodouct_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return homeScreenContent(state, context);
          },
        ),
      ),
    );
  }
}

Widget homeScreenContent(HomeState state, BuildContext context) {
  if (state is HomeLoadingState) {
    return Center(child: LoadingAnimation());
  } else if (state is HomeRequestSuccessState) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(HomeGetInitializeData());
      },
      child: CustomScrollView(
        slivers: [
          ...{
            _SearchBox(),
            ...[
              state.bannerList.fold(
                (l) {
                  return SliverToBoxAdapter(child: Text(l));
                },
                (r) {
                  return _GetBannr(bannerList: r);
                },
              ),
            ],

            _GetCategoryListTitle(),
            ...[
              state.categoryList.fold(
                (l) {
                  return SliverToBoxAdapter(child: Text(l));
                },
                (r) {
                  return _GetCategoryList(listCategories: r);
                },
              ),
            ],

            _GetBestSellerTitle(),
            ...[
              state.bestSellerProduct.fold(
                (l) {
                  return SliverToBoxAdapter(child: Text(l));
                },
                (r) {
                  return _GetBestSellerProdouct(r);
                },
              ),
            ],

            _MostViewTitle(),
            ...[
              state.hotestProduct.fold(
                (l) {
                  return SliverToBoxAdapter(child: Text(l));
                },
                (r) {
                  return _MostViewProdouct(r);
                },
              ),
            ],
          },
        ],
      ),
    );
  } else {
    return Text("خطایی در دریافت اطلاعات به وجود امده");
  }
}



class _MostViewProdouct extends StatelessWidget {
  List<Product> productList;

  _MostViewProdouct(this.productList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44.0),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ProdouctItem(productList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MostViewTitle extends StatelessWidget {
  const _MostViewTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 44,
          right: 44,
          bottom: 20,
          top: 32,
        ),
        child: Row(
          children: [
            Text(
              'پر بازدید ترین ها',
              style: TextStyle(fontFamily: 'SB', color: CustomColors.gery),
            ),
            Spacer(),

            Text(
              'مشاهده همه',
              style: TextStyle(fontFamily: 'SB', color: CustomColors.blue),
            ),
            SizedBox(width: 10),
            Image.asset('assets/images/icon_left_categroy.png'),
          ],
        ),
      ),
    );
  }
}

class _GetBestSellerProdouct extends StatelessWidget {
  List<Product> productList;

  _GetBestSellerProdouct(this.productList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44.0),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ProdouctItem(productList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GetBestSellerTitle extends StatelessWidget {
  const _GetBestSellerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
        child: Row(
          children: [
            Text(
              'پرفروش ترین ها',
              style: TextStyle(fontFamily: 'SB', color: CustomColors.gery),
            ),
            Spacer(),

            Text(
              'مشاهده همه',
              style: TextStyle(fontFamily: 'SB', color: CustomColors.blue),
            ),
            SizedBox(width: 10),
            Image.asset('assets/images/icon_left_categroy.png'),
          ],
        ),
      ),
    );
  }
}

class _GetCategoryList extends StatelessWidget {
  List<Category>? listCategories;

  _GetCategoryList({super.key, required this.listCategories});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44.0),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listCategories?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: CategoryItemChip(category: listCategories![index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GetCategoryListTitle extends StatelessWidget {
  const _GetCategoryListTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 44.0,
          right: 44,
          bottom: 20,
          top: 32,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'دسته بندی',
              style: TextStyle(fontFamily: 'SB', color: CustomColors.gery),
            ),
          ],
        ),
      ),
    );
  }
}

class _GetBannr extends StatelessWidget {
  List<MyBanner> bannerList;

  _GetBannr({super.key, required this.bannerList});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: BannerSlider(bannerList: bannerList));
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 44, bottom: 32),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            children: [
              SizedBox(width: 10),
              Image.asset('assets/images/icon_search.png'),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  textAlign: TextAlign.start,
                  'جستجوی محصولات',
                  style: TextStyle(
                    color: CustomColors.gery,
                    fontSize: 16,
                    fontFamily: 'SM',
                  ),
                ),
              ),

              Image.asset('assets/images/icon_apple_blue.png'),
              SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
