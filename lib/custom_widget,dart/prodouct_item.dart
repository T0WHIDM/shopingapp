import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_sample/Data/model/product.dart';
import 'package:flutter_shop_sample/bloc/basket/basket_bloc.dart';
import 'package:flutter_shop_sample/constants/colors.dart';
import 'package:flutter_shop_sample/custom_widget,dart/cached_image.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/screens/prodouct_detail_screen.dart';
import 'package:flutter_shop_sample/utility/extentions/int_extention.dart';

class ProdouctItem extends StatelessWidget {
  final Product product;

  const ProdouctItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider<BasketBloc>.value(
                value: locator.get<BasketBloc>(),
                child: ProdouctDetailScreen(product),
              );
            },
          ),
        );
      },
      child: Container(
        width: 160,
        height: 216,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Expanded(child: Container()),
                SizedBox(
                  height: 98,
                  width: 98,
                  child: CachedImage(imageUrl: product.thumbnail),
                ),
                Positioned(
                  top: 0,
                  right: 10,
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset('assets/images/active_fav_product.png'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 8,
                  child: Container(
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
                        '${product.percent!.round().toString()} %',
                        style: TextStyle(fontFamily: 'SB', fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Text(
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    product.name,
                    style: TextStyle(fontFamily: 'SM', fontSize: 14),
                  ),
                ),

                Container(
                  height: 53,
                  decoration: BoxDecoration(
                    color: CustomColors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.blue,
                        blurRadius: 25,
                        spreadRadius: -12,
                        offset: Offset(0.0, 15),
                      ),
                    ],
                  ),
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
                              product.realPrice.convertToPrice(),
                              style: TextStyle(
                                fontFamily: 'SB',
                                fontSize: 12,
                                color: Colors.white,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              product.price.convertToPrice(),
                              style: TextStyle(
                                fontFamily: 'SM',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 24,
                          child: Image.asset(
                            'assets/images/icon_right_arrow_cricle.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
