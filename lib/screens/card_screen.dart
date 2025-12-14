import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_sample/constants/colors.dart';
import 'package:flutter_shop_sample/utility/extentions/string_extentions.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CustomScrollView(
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
                              'سبد خرید',
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
                SliverList(
                  delegate: SliverChildBuilderDelegate(childCount: 10, (
                    context,
                    index,
                  ) {
                    return CardItem();
                  }),
                ),
                SliverPadding(padding: EdgeInsets.only(bottom: 100)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 44.0,
                right: 44.0,
                bottom: 20,
              ),
              child: SizedBox(
                height: 53,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.green,
                  ),
                  onPressed: () {},
                  child: Text(
                    'ادامه فرایند خرید',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SM',
                      fontSize: 18,
                    ),
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

class CardItem extends StatelessWidget {
  const CardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 249,
      margin: EdgeInsets.only(left: 44, right: 44, top: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'آیفون 13 پرومکس',
                          style: TextStyle(fontFamily: 'SB', fontSize: 16),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'گارانتی 18 ماه مدیا پردازش',
                          style: TextStyle(fontSize: 12, fontFamily: 'SM'),
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 6,
                                ),
                                child: Text(
                                  '%3',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'SB',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'تومان',
                              style: TextStyle(fontSize: 12, fontFamily: 'SM'),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '1550000',
                              style: TextStyle(fontSize: 12, fontFamily: 'SM'),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Wrap(
                          spacing: 8,

                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: CustomColors.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 2,
                                  bottom: 2,
                                  right: 8,
                                  left: 8,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'حذف',
                                      style: TextStyle(
                                        color: CustomColors.red,
                                        fontFamily: 'SM',
                                        fontSize: 12,
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    SizedBox(width: 4),
                                    Image.asset('assets/images/icon_trash.png'),
                                  ],
                                ),
                              ),
                            ),

                            OptionsCheap('آبی', color: '4287a5'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Image.asset('assets/images/iphone.png'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: DottedLine(
              lineThickness: 3,
              dashLength: 8,
              dashColor: CustomColors.gery.withOpacity(0.5),
              dashGapLength: 3,
              dashGapColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('تومان', style: TextStyle(fontFamily: 'SB', fontSize: 16)),
                SizedBox(width: 4),
                Text(
                  '59000000',
                  style: TextStyle(fontFamily: 'SB', fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionsCheap extends StatelessWidget {
  String? color;
  String title;

  OptionsCheap(this.title, {this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.gery, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 2, right: 8, left: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(right: 4),
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.parseToColor(),
              ),
            ),

            Text(
              title,
              style: TextStyle(fontFamily: 'SM', fontSize: 12),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
