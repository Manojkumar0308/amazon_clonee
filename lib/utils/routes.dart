import 'dart:io';

import 'package:amazon_clone/checkout/view/checkout_screen.dart';
import 'package:amazon_clone/main.dart';
import 'package:amazon_clone/product/view/product_detail.dart';
import 'package:amazon_clone/screens/bottomnav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/view/create_account.dart';
import '../auth/view/sign_in.dart';
import '../auth/view/welcome_screen.dart';
import '../product/view/add_product_screen.dart';
import '../product/view/product_screen.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/bottom-nav':
      return _buildAdaptiveRoute(const BottomNavScreen());
    case '/create_account':
      return _buildAdaptiveRoute(const CreateAccount());
    case '/sign_in':
      return _buildAdaptiveRoute(const SignInScreen());
    case '/welcome':
      return _buildAdaptiveRoute(const WelcomeScreen());
    case '/add-product':
      return _buildAdaptiveRoute(const AddProductScreen());

    // case '/products':
    //   return _buildAdaptiveRoute(const ProductScreen(navigatorKey: null,));
    case '/product-detail':
      final args = settings.arguments as Map<String, dynamic>;
      return _buildAdaptiveRoute(ProductDetailScreen(productId: args['productId']));
    default:
      return _buildAdaptiveRoute(const WelcomeScreen()); // default screen
  }
}

Route _buildAdaptiveRoute(Widget screen) {
  if (Platform.isIOS) {
    return CupertinoPageRoute(builder: (_) => screen);
  } else {
    return MaterialPageRoute(builder: (_) => screen);
  }
}
