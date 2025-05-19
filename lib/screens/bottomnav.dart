import 'package:amazon_clone/product/view_model/product_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cart/view/cart_screen.dart';
import '../category/view/category_screen.dart';
import '../product/view/product_screen.dart';
import '../profile/view/profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onTap(int index) {
    if (index == selectedIndex) {
      navigatorKeys[index]
          .currentState!
          .popUntil((route) => route.isFirst);
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(int index) {
    final user = FirebaseAuth.instance.currentUser;
    return Offstage(
      offstage: selectedIndex != index,
      child: Navigator(
        key: navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          Widget page;
          switch (index) {
            case 0:
              page = ProductScreen(navigatorKey: navigatorKeys[0]);
              break;
            case 1:
              page = CategoryScreen(navigatorKey: navigatorKeys[1]);
              break;
            case 2:
              page = CartScreen(
                navigatorKey: navigatorKeys[2], userId: '${user?.uid}',);
              break;
            case 3:
              page = ProfileScreen(email: '${user?.email}',
                  uid: '${user?.uid}',
                  navigatorKey: navigatorKeys[3]);
              break;
            default:
              page = ProductScreen(navigatorKey: navigatorKeys[0]);
          }
          return MaterialPageRoute(builder: (_) => page);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: List.generate(4, (index) => _buildOffstageNavigator(index)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onTap,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_sharp), label: "Home"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: "Category"),
          BottomNavigationBarItem(
            icon: Consumer<ProductViewModel>(
                builder: (context, provider, child) {
                  int count = provider.totalCartCount;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Icons.shopping_cart_outlined),
                      if (count > 0)
                        Positioned(
                          right: -6,
                          top: -3,
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Center(
                              child: Text(
                                '$count',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );

                }

            ),
            label: "Cart",
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}