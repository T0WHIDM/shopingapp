import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_sample/Data/model/category.dart';
import 'package:flutter_shop_sample/bloc/category/category_bloc.dart';
import 'package:flutter_shop_sample/bloc/category/category_event.dart';
import 'package:flutter_shop_sample/bloc/category/category_state.dart';
import 'package:flutter_shop_sample/constants/colors.dart';
import 'package:flutter_shop_sample/custom_widget,dart/cached_image.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category>? list;

  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
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
                      Image.asset('assets/images/icon_apple_blue.png'),
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.center,
                          'دسته بندی',
                          style: TextStyle(
                            color: CustomColors.blue,
                            fontSize: 16,
                            fontFamily: 'SM',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoadingState) {
                  return SliverToBoxAdapter(child: CircularProgressIndicator());
                }
                if (state is CategoryResponseState) {
                  return state.response.fold(
                    (l) {
                      return SliverToBoxAdapter(child: Center(child: Text(l)));
                    },
                    (r) {
                      return _listCategory(list: r);
                    },
                  );
                }
                return SliverToBoxAdapter(child: Text('error'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _listCategory extends StatelessWidget {
  List<Category>? list;

  _listCategory({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(childCount: list?.length ?? 0, (
          context,
          index,
        ) {
          return CachedImage(imageUrl: list?[index].thumbnail);
        }),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
