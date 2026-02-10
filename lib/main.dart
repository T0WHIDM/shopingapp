import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_sample/Data/model/basket_item.dart';
import 'package:flutter_shop_sample/bloc/authitication/auth_bloc.dart';
import 'package:flutter_shop_sample/bloc/basket/basket_bloc.dart';
import 'package:flutter_shop_sample/bloc/basket/basket_event.dart';
import 'package:flutter_shop_sample/bloc/category/category_bloc.dart';
import 'package:flutter_shop_sample/bloc/home/home_bloc.dart';
import 'package:flutter_shop_sample/bloc/home/home_event.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/screens/card_screen.dart';
import 'package:flutter_shop_sample/screens/category_screen.dart';
import 'package:flutter_shop_sample/screens/dashboard_screen.dart';
import 'package:flutter_shop_sample/screens/home_screen.dart';
import 'package:flutter_shop_sample/screens/login_screen.dart';
import 'package:flutter_shop_sample/screens/profile_screen.dart';
import 'package:flutter_shop_sample/utility/auth_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('basketBox');

  await getItInit();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (AuthManager.readAuth().isEmpty)
          ? BlocProvider(create: (context) => AuthBloc(), child: LoginScreen())
          : DashboardScreen(),
    );
  }
}
