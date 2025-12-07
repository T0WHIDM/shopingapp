import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_sample/Data/model/product_image.dart';
import 'package:flutter_shop_sample/Data/model/product_variant.dart';
import 'package:flutter_shop_sample/Data/model/variant.dart';
import 'package:flutter_shop_sample/Data/model/variants_type.dart';
import 'package:flutter_shop_sample/Data/repository/product_detail_repository.dart';
import 'package:flutter_shop_sample/bloc/product/product_bloc.dart';
import 'package:flutter_shop_sample/bloc/product/product_event.dart';
import 'package:flutter_shop_sample/bloc/product/product_state.dart';
import 'package:flutter_shop_sample/constants/colors.dart';
import 'package:flutter_shop_sample/custom_widget,dart/cached_image.dart';
import 'package:flutter_shop_sample/di/di.dart';

class ProdouctDetailScreen extends StatefulWidget {
  const ProdouctDetailScreen({super.key});

  @override
  State<ProdouctDetailScreen> createState() => _ProdouctDetailScreenState();
}

class _ProdouctDetailScreenState extends State<ProdouctDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(ProductInitializeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is ProductLoadingState) ...[
                  SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],

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
                              'ایفون',
                              style: TextStyle(
                                color: CustomColors.blue,
                                fontSize: 16,
                                fontFamily: 'SM',
                              ),
                            ),
                          ),
                          Image.asset('assets/images/icon_back.png'),
                          SizedBox(width: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      'se 2022 آیفون',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SB',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                if (state is ProductResponseState) ...[
                  state.productImages.fold(
                    (l) {
                      return SliverToBoxAdapter(child: Text(l));
                    },
                    (r) {
                      return galleryWidget(r);
                    },
                  ),
                ],

                if (state is ProductResponseState) ...[
                  state.productVariant.fold(
                    (l) {
                      return SliverToBoxAdapter(child: Text(l));
                    },
                    (productVariantList) {
                      return VariantContainer(productVariantList);
                    },
                  ),
                ],

                // SliverToBoxAdapter(
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //       top: 20.0,
                //       right: 44,
                //       left: 44,
                //     ),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.end,
                //       children: [
                //         Text(
                //           'انتخاب حافظه داخلی',
                //           style: TextStyle(fontSize: 12, fontFamily: 'SM'),
                //         ),
                //         SizedBox(height: 10),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             Container(
                //               margin: EdgeInsets.only(left: 10),
                //               height: 25,
                //               decoration: BoxDecoration(
                //                 color: Colors.white,
                //                 border: Border.all(
                //                   width: 1,
                //                   color: CustomColors.gery,
                //                 ),
                //                 borderRadius: BorderRadius.all(
                //                   Radius.circular(8),
                //                 ),
                //               ),
                //               child: Padding(
                //                 padding: const EdgeInsets.symmetric(
                //                   horizontal: 20.0,
                //                 ),
                //                 child: Center(
                //                   child: Text(
                //                     '256',
                //                     style: TextStyle(
                //                       fontFamily: 'SB',
                //                       fontSize: 12,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             Container(
                //               margin: EdgeInsets.only(left: 10),
                //               height: 25,
                //               decoration: BoxDecoration(
                //                 color: Colors.white,
                //                 border: Border.all(
                //                   width: 1,
                //                   color: CustomColors.gery,
                //                 ),
                //                 borderRadius: BorderRadius.all(
                //                   Radius.circular(8),
                //                 ),
                //               ),
                //               child: Padding(
                //                 padding: const EdgeInsets.symmetric(
                //                   horizontal: 20.0,
                //                 ),
                //                 child: Center(
                //                   child: Text(
                //                     '128',
                //                     style: TextStyle(
                //                       fontFamily: 'SB',
                //                       fontSize: 12,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             Container(
                //               margin: EdgeInsets.only(left: 10),
                //               height: 25,
                //               decoration: BoxDecoration(
                //                 color: Colors.white,
                //                 border: Border.all(
                //                   width: 1,
                //                   color: CustomColors.gery,
                //                 ),
                //                 borderRadius: BorderRadius.all(
                //                   Radius.circular(8),
                //                 ),
                //               ),
                //               child: Padding(
                //                 padding: const EdgeInsets.symmetric(
                //                   horizontal: 20.0,
                //                 ),
                //                 child: Center(
                //                   child: Text(
                //                     '64',
                //                     style: TextStyle(
                //                       fontFamily: 'SB',
                //                       fontSize: 12,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 46,
                    margin: EdgeInsets.only(left: 44, right: 44, top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: CustomColors.gery, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Image.asset('assets/images/icon_left_categroy.png'),
                        SizedBox(width: 10),
                        Text(
                          'مشاهده',
                          style: TextStyle(
                            color: CustomColors.blue,
                            fontFamily: 'SB',
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        Text(
                          ': مشخصات فنی',
                          style: TextStyle(fontFamily: 'SB', fontSize: 12),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 46,
                    margin: EdgeInsets.only(left: 44, right: 44, top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: CustomColors.gery, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Image.asset('assets/images/icon_left_categroy.png'),
                        SizedBox(width: 10),
                        Text(
                          'مشاهده',
                          style: TextStyle(
                            color: CustomColors.blue,
                            fontFamily: 'SB',
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        Text(
                          ': توضیحات محصول',
                          style: TextStyle(fontFamily: 'SB', fontSize: 12),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 46,
                    margin: EdgeInsets.only(left: 44, right: 44, top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: CustomColors.gery, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Image.asset('assets/images/icon_left_categroy.png'),
                        SizedBox(width: 10),
                        Text(
                          'مشاهده',
                          style: TextStyle(
                            color: CustomColors.blue,
                            fontFamily: 'SB',
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 15,
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 26,
                                width: 26,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 30,
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 26,
                                width: 26,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 45,
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 26,
                                width: 26,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '+10',
                                    style: TextStyle(
                                      fontFamily: 'SB',
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Text(
                          ': نظرات کاربران',
                          style: TextStyle(fontFamily: 'SB', fontSize: 12),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 44,
                      right: 44,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [PriceWidget(), AddToBasketWidget()],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class VariantContainer extends StatelessWidget {
  List<ProductVariant> productVariantList;

  VariantContainer(this.productVariantList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, right: 44, left: 44),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              productVariantList[0].variantsType.title!,
              style: TextStyle(fontSize: 12, fontFamily: 'SM'),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...colorVariantOptions(productVariantList[0].variantList),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> colorVariantOptions(List<Variant> variantList) {
  List<Widget> colorWidget = [];

  for (var variantColor in variantList) {
    String categoryColor = 'FF${variantColor.value}';
    int hexColor = int.parse(categoryColor, radix: 16);

    var item = Container(
      height: 26,
      width: 26,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Color(hexColor),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
    colorWidget.add(item);
  }

  return colorWidget;
}

class galleryWidget extends StatefulWidget {
  List<ProductImage> productImagesList;
  int selectedItem = 0;

  galleryWidget(this.productImagesList, {super.key});

  @override
  State<galleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<galleryWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44.0),
        child: Container(
          height: 284,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 10.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/images/icon_star.png'),
                          SizedBox(width: 4),
                          Text(
                            '4.6',
                            style: TextStyle(fontFamily: 'SM', fontSize: 12),
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                        height: double.infinity,
                        child: CachedImage(
                          imageUrl: widget
                              .productImagesList[widget.selectedItem]
                              .imageUrl,
                        ),
                      ),
                      Spacer(),
                      Image.asset('assets/images/icon_favorite_deactive.png'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(left: 80.0, right: 60, top: 5),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productImagesList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.selectedItem = index;
                          });
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CustomColors.gery,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: CachedImage(
                            imageUrl: widget.productImagesList[index].imageUrl,
                            radius: 10,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class AddToBasketWidget extends StatelessWidget {
  const AddToBasketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Positioned(
          child: Container(
            height: 60,
            width: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: CustomColors.blue,
            ),
          ),
        ),
        Positioned(
          child: GestureDetector(
            onTap: () async {
              IproductDetailRepository repository = locator.get();
              var response = await repository.getProductimage();

              response.fold((l) {}, (r) {
                r.forEach((element) {
                  print(element.imageUrl);
                });
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: SizedBox(
                  height: 53,
                  width: 160,
                  child: Center(
                    child: Text(
                      'افزودن به سبد خرید',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Positioned(
          child: Container(
            height: 60,
            width: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: CustomColors.green,
            ),
          ),
        ),
        Positioned(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: SizedBox(
                height: 53,
                width: 160,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'تومان',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SM',
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '54000000',
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 12,
                              color: Colors.white,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            '50000000',
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 6,
                          ),
                          child: Text(
                            '%3',
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
