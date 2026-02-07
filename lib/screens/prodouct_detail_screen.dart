import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_sample/Data/model/product.dart';
import 'package:flutter_shop_sample/Data/model/product_image.dart';
import 'package:flutter_shop_sample/Data/model/product_variant.dart';
import 'package:flutter_shop_sample/Data/model/properties.dart';
import 'package:flutter_shop_sample/Data/model/variant.dart';
import 'package:flutter_shop_sample/Data/model/variants_type.dart';
import 'package:flutter_shop_sample/bloc/basket/basket_bloc.dart';
import 'package:flutter_shop_sample/bloc/basket/basket_event.dart';
import 'package:flutter_shop_sample/bloc/comment/comment_bloc.dart';
import 'package:flutter_shop_sample/bloc/comment/comment_event.dart';
import 'package:flutter_shop_sample/bloc/comment/comment_state.dart';
import 'package:flutter_shop_sample/bloc/product/product_bloc.dart';
import 'package:flutter_shop_sample/bloc/product/product_event.dart';
import 'package:flutter_shop_sample/bloc/product/product_state.dart';
import 'package:flutter_shop_sample/constants/colors.dart';
import 'package:flutter_shop_sample/custom_widget,dart/cached_image.dart';
import 'package:flutter_shop_sample/custom_widget,dart/loading_animaation.dart';

class ProdouctDetailScreen extends StatefulWidget {
  final Product product;

  const ProdouctDetailScreen(this.product, {super.key});

  @override
  State<ProdouctDetailScreen> createState() => _ProdouctDetailScreenState();
}

class _ProdouctDetailScreenState extends State<ProdouctDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = ProductBloc();
        bloc.add(
          ProductInitializeEvent(widget.product.id, widget.product.categoryId),
        );
        return bloc;
      },
      child: DetailContentWidget(parentWidget: widget),
    );
  }
}

class DetailContentWidget extends StatelessWidget {
  const DetailContentWidget({super.key, required this.parentWidget});

  final ProdouctDetailScreen parentWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return Center(child: LoadingAnimation());
          }
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is ProductSuccessResponseState) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 44,
                        right: 44,
                        bottom: 32,
                      ),
                      child: Container(
                        height: 46,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Image.asset('assets/images/icon_apple_blue.png'),
                            Expanded(
                              child: state.productCategory.fold(
                                (l) {
                                  return const Text(
                                    'اطلاعات محصول',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'sb',
                                      fontSize: 16,
                                      color: CustomColors.blue,
                                    ),
                                  );
                                },
                                (productCategory) {
                                  return Text(
                                    productCategory.title!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'sb',
                                      fontSize: 16,
                                      color: CustomColors.blue,
                                    ),
                                  );
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Image.asset('assets/images/icon_back.png'),
                            ),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                },
                if (state is ProductSuccessResponseState) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        parentWidget.product.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SB',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                },

                if (state is ProductSuccessResponseState) ...[
                  state.productImages.fold(
                    (l) {
                      return SliverToBoxAdapter(child: Text(l));
                    },
                    (r) {
                      return galleryWidget(r, parentWidget.product.thumbnail);
                    },
                  ),
                ],

                if (state is ProductSuccessResponseState) ...[
                  state.productVariant.fold(
                    (l) {
                      return SliverToBoxAdapter(child: Text(l));
                    },
                    (productVariantList) {
                      return VariantContainerGenerator(productVariantList);
                    },
                  ),
                ],
                if (state is ProductSuccessResponseState) ...{
                  state.productProperties.fold(
                    (l) {
                      return SliverToBoxAdapter(child: Text(l));
                    },
                    (propertyList) {
                      return ProductProperties(propertyList);
                    },
                  ),
                },
                if (state is ProductSuccessResponseState) ...{
                  ProductDescription(parentWidget.product.description),
                },
                if (state is ProductSuccessResponseState) ...{
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return BlocProvider(
                              create: (context) {
                                final bloc = CommentBloc();
                                bloc.add(
                                  CommentInitialEvent(parentWidget.product.id),
                                );
                                return bloc;
                              },
                              child: DraggableScrollableSheet(
                                initialChildSize: 0.6,
                                maxChildSize: 0.7,
                                minChildSize: 0.2,
                                builder: (context, scrollController) {
                                  return CommentBottomSheet(scrollController);
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 46,
                        margin: EdgeInsets.only(left: 44, right: 44, top: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: CustomColors.gery,
                            width: 1,
                          ),
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
                  ),
                },
                if (state is ProductSuccessResponseState) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 44,
                        right: 44,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PriceWidget(),
                          AddToBasketWidget(parentWidget.product),
                        ],
                      ),
                    ),
                  ),
                },
              ],
            ),
          );
        },
      ),
    );
  }
}

class CommentBottomSheet extends StatelessWidget {
  final ScrollController controller;
  const CommentBottomSheet(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentLoadingState) {
          return Center(child: LoadingAnimation());
        }
        return CustomScrollView(
          controller: controller,
          slivers: [
            if (state is CommentResponseState) ...{
              state.response.fold(
                (error) {
                  return Text('error');
                },
                (commentList) {
                  if (commentList.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text('نظری برای این محصول ثیت نشده'),
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: commentList.length,
                      (context, index) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    commentList[index].text,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                SizedBox(width: 15),
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CachedImage(
                                    radius: 16,
                                    imageUrl:
                                        commentList[index].userThumbnailUrl,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            },
          ],
        );
      },
    );
  }
}

class ProductProperties extends StatefulWidget {
  final List<Property> productPropertyList;

  const ProductProperties(this.productPropertyList, {super.key});

  @override
  State<ProductProperties> createState() => _ProductPropertiesState();
}

class _ProductPropertiesState extends State<ProductProperties> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: CustomColors.gery),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Image.asset('assets/images/icon_left_categroy.png'),
                  const SizedBox(width: 10),
                  const Text(
                    'مشاهده',
                    style: TextStyle(
                      fontFamily: 'sb',
                      fontSize: 12,
                      color: CustomColors.blue,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    ': مشخصات فنی ',
                    style: TextStyle(fontFamily: 'sm'),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: CustomColors.gery),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.productPropertyList.length,
                itemBuilder: (context, index) {
                  var property = widget.productPropertyList[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          '${property.value!} : ${property.title!}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'sm',
                            fontSize: 14,
                            height: 1.8,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  final String productDescriptions;

  const ProductDescription(this.productDescriptions, {super.key});

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
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
          Visibility(
            visible: _isVisible,
            child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(left: 44, right: 44, top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: CustomColors.gery, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Text(
                widget.productDescriptions,
                style: TextStyle(fontFamily: 'SM', fontSize: 14, height: 2),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  final List<ProductVariant> productVariantList;

  const VariantContainerGenerator(this.productVariantList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var productVariant in productVariantList) ...{
            if (productVariant.variants.isNotEmpty) ...{
              VariantGeneratorChild(productVariant),
            },
          },
        ],
      ),
    );
  }
}

class VariantGeneratorChild extends StatelessWidget {
  final ProductVariant productVariant;

  const VariantGeneratorChild(this.productVariant, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 44, left: 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType.title!,
            style: TextStyle(fontSize: 12, fontFamily: 'SM'),
          ),
          SizedBox(height: 10),
          if (productVariant.variantType.type == VariantTypeEnum.COLOR) ...{
            ColorVariantList(productVariant.variants),
          },
          if (productVariant.variantType.type == VariantTypeEnum.STORAGE) ...{
            StorageVariantList(productVariant.variants),
          },
        ],
      ),
    );
  }
}

class galleryWidget extends StatefulWidget {
  List<ProductImage> productImagesList;
  String defualtProductThumbnail;
  int selectedItem = 0;

  galleryWidget(
    this.productImagesList,
    this.defualtProductThumbnail, {
    super.key,
  });

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
                        height: 150,
                        width: 150,
                        child: CachedImage(
                          imageUrl: (widget.productImagesList.isEmpty)
                              ? widget.defualtProductThumbnail
                              : widget
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
              if (widget.productImagesList.isNotEmpty) ...{
                SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 80.0,
                      right: 60,
                      top: 5,
                    ),
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: CachedImage(
                              imageUrl:
                                  widget.productImagesList[index].imageUrl,
                              radius: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              },
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class AddToBasketWidget extends StatelessWidget {
  Product product;

  AddToBasketWidget(this.product, {super.key});

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
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: GestureDetector(
                onTap: () {
                  context.read<ProductBloc>().add(ProductAddToBasket(product));
                  context.read<BasketBloc>().add(BasketRequestEvent());
                },
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

class ColorVariantList extends StatefulWidget {
  List<Variant> variantList;

  ColorVariantList(this.variantList, {super.key});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 32,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.variantList.length,
          itemBuilder: (context, index) {
            String categoryColor = 'FF${widget.variantList[index].value}';
            int hexColor = int.parse(categoryColor, radix: 16);
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedindex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.all(2),
                height: 32,
                width: 32,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: (selectedindex == index)
                      ? Border.all(
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: 3,
                          color: CustomColors.blueIndicator,
                        )
                      : Border.all(width: 2, color: Colors.white),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(hexColor),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  List<Variant> storageVariant;

  StorageVariantList(this.storageVariant, {super.key});

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.storageVariant.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: (selectedIndex == index)
                      ? Border.all(width: 2, color: CustomColors.blueIndicator)
                      : Border.all(width: 1, color: CustomColors.gery),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Text(
                      widget.storageVariant[index].value!,
                      style: TextStyle(fontFamily: 'SB', fontSize: 12),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
