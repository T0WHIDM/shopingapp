import 'package:flutter/material.dart';
import 'package:flutter_shop_sample/Data/model/category.dart';
import 'package:flutter_shop_sample/constants/colors.dart';

class ProdouctListScreen extends StatefulWidget {
  Category category;

  ProdouctListScreen(this.category, {super.key});

  @override
  State<ProdouctListScreen> createState() => _ProdouctListScreenState();
}

class _ProdouctListScreenState extends State<ProdouctListScreen> {
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
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 44),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(childCount: 15, (
                  context,
                  index,
                ) {
                  return Text('1');
                  // return ProdouctItem();
                }),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2 / 2.7,
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
