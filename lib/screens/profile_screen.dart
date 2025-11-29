import 'package:flutter/material.dart';
import 'package:flutter_shop_sample/constants/colors.dart';
import 'package:flutter_shop_sample/custom_widget,dart/category_item_chip.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
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
                        'حساب کاربری',
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
            Text(
              'توحید غلامی',
              style: TextStyle(fontFamily: 'SB', fontSize: 16),
            ),
            Text(
              '09364582386',
              style: TextStyle(fontFamily: 'SM', fontSize: 10),
            ),
            SizedBox(height: 30),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                ],
              ),
            ),
            Spacer(),
            Text(
              'اپل شاپ',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 10,
                color: CustomColors.gery,
              ),
            ),
            Text(
              'v-1.1.5',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 10,
                color: CustomColors.gery,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
