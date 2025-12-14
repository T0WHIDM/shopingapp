import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_sample/Data/model/category.dart';
import 'package:flutter_shop_sample/bloc/categoryProduct/category_product_bloc.dart';
import 'package:flutter_shop_sample/bloc/categoryProduct/category_product_event.dart';
import 'package:flutter_shop_sample/bloc/categoryProduct/category_product_state.dart';
import 'package:flutter_shop_sample/constants/colors.dart';
import 'package:flutter_shop_sample/custom_widget,dart/prodouct_item.dart';

class ProdouctListScreen extends StatefulWidget {
  Category category;

  ProdouctListScreen(this.category, {super.key});

  @override
  State<ProdouctListScreen> createState() => _ProdouctListScreenState();
}

class _ProdouctListScreenState extends State<ProdouctListScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(
      context,
    ).add(CatagoryProductInitialize(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryProductState>(
      builder: (context, state) {
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
                              textAlign: TextAlign.center,
                              widget.category.title!,
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
                if (state is CategoryProductLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                },
                if (state is CategoryProductResponseSuccessState) ...{
                  state.categoryProductList.fold(
                    (l) {
                      return SliverToBoxAdapter(child: Text(l));
                    },
                    (r) {
                      return SliverPadding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 44),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            childCount: r.length,
                            (context, index) {
                              return ProdouctItem(r[index]);
                            },
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 2 / 2.7,
                                crossAxisCount: 2,
                                mainAxisSpacing: 30,
                                crossAxisSpacing: 30,
                              ),
                        ),
                      );
                    },
                  ),
                },
              ],
            ),
          ),
        );
      },
    );
  }
}
