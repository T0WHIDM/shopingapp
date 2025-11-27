import 'package:flutter/material.dart';
import 'package:flutter_shop_sample/Data/repository/category_repository.dart';
import 'package:flutter_shop_sample/constants/colors.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () async {
                  var repository = CategoryRepository();
                  var either = await repository.getCategories();
                  either.fold(
                    (l) {
                      print(l);
                    },
                    (r) {
                      r.forEach((element) {
                        print(element.title);
                      });
                    },
                  );
                },
                child: Text('hello'),
              ),
            ),
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
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 44),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(childCount: 15, (
                  context,
                  index,
                ) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  );
                }),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
