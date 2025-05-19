import 'package:amazon_clone/product/model/dummy_product.dart';
import 'package:amazon_clone/product/view_model/product_view_model.dart';
import 'package:amazon_clone/screens/bottomnav.dart';
import 'package:amazon_clone/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'auth/view/welcome_screen.dart';
import 'auth/view_model/auth_view_model.dart';

import 'utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD9IqQMw6Azh3gBWnQTLJhXhR1Mrbdx36k",
          authDomain: "clone-24eee.firebaseapp.com",
          projectId: "clone-24eee",
          storageBucket: "clone-24eee.firebasestorage.app",
          messagingSenderId: "499208284224",
          appId: "1:499208284224:web:25557c0575ff3203b897a5",
          measurementId: "G-920ZCSSZX0",
          databaseURL: "https://clone-24eee-default-rtdb.firebaseio.com/"),
    );
  } else {
    await Firebase.initializeApp();
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthViewModel()),
    ChangeNotifierProvider(
      create: (_) => ProductViewModel()..fetchProducts(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // addDummyProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: AppColors.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      // initialRoute: '/welcome',
      onGenerateRoute: generateRoute,
      home: user != null ? const BottomNavScreen() : const WelcomeScreen(),
    );
  }
}
