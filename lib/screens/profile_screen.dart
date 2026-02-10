import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_sample/bloc/authitication/auth_bloc.dart';
import 'package:flutter_shop_sample/bloc/authitication/auth_state.dart';
import 'package:flutter_shop_sample/constants/colors.dart';
import 'package:flutter_shop_sample/custom_widget,dart/category_item_chip.dart';
import 'package:flutter_shop_sample/main.dart';
import 'package:flutter_shop_sample/screens/dashboard_screen.dart';
import 'package:flutter_shop_sample/screens/login_screen.dart';
import 'package:flutter_shop_sample/utility/auth_manager.dart';

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
            ElevatedButton(
              onPressed: () {
                AuthManager.logOut();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return BlocProvider(
                        create: (context) {
                          var authBloc = AuthBloc();
                          authBloc.stream.forEach((state) {
                            if (state is AuthResponseState) {
                              state.response.fold((l) {}, (r) {
                                globalNavigatorKey.currentState
                                    ?.pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return DashboardScreen();
                                        },
                                      ),
                                    );
                              });
                            }
                          });
                          return authBloc;
                        },
                        child: LoginScreen(),
                      );
                    },
                  ),
                );
              },
              child: Text('خروج از حساب کاربری'),
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
