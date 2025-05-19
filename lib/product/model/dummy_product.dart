import 'package:amazon_clone/product/model/product_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/product_view_model.dart';

void addDummyProducts(BuildContext context) async {
  final DatabaseReference ref = FirebaseDatabase.instance.ref().child('products');
  final products = Provider.of<ProductViewModel>(context, listen: false);

  final List<Product> dummyProducts = [
    Product(
      id: 'p1',
      name: 'iPhone 14 Pro',
      description: 'Latest Apple iPhone with A16 Bionic chip.',
      imageUrl: 'https://m.media-amazon.com/images/I/31VjlrbE3bL._SX300_SY300_QL70_FMwebp_.jpg',
      brand: 'Apple',
      category: 'Mobiles',
      price: 1299.99,
    ),
    Product(
      id: 'p2',
      name: 'Samsung Galaxy S23',
      description: 'Samsung flagship smartphone with great performance.',
      imageUrl: 'https://m.media-amazon.com/images/I/31SrIF+Tt7L._SY300_SX300_.jpg',
      brand: 'Samsung',
      category: 'Mobiles',
      price: 1199.99,
    ),
    Product(
      id: 'p3',
      name: 'Sony WH-1000XM5',
      description: 'Industry leading noise cancelling headphones.',
      imageUrl: 'https://m.media-amazon.com/images/I/31vOBg8cPaL._SX300_SY300_QL70_FMwebp_.jpg',
      brand: 'Sony',
      category: 'Headphones',
      price: 349.99,
    ),
    Product(
      id: 'p4',
      name: 'Dell XPS 13',
      description: 'Powerful and compact ultrabook from Dell.',
      imageUrl: 'https://m.media-amazon.com/images/I/41TzA2xrH+L._SY300_SX300_.jpg',
      brand: 'Dell',
      category: 'Laptops',
      price: 1399.99,
    ),
    Product(
      id: 'p5',
      name: 'Apple Watch Series 8',
      description: 'Smartwatch with health and fitness tracking.',
      imageUrl: 'https://m.media-amazon.com/images/I/71Ll7RaekYL._AC_UY218_.jpg',
      brand: 'Apple',
      category: 'Watches',
      price: 499.99,
    ),
    Product(
      id: 'p6',
      name: 'Nike Air Max 270',
      description: 'Comfortable and stylish running shoes.',
      imageUrl: 'https://m.media-amazon.com/images/I/613fjQtsd2L._AC_UL320_.jpg',
      brand: 'Nike',
      category: 'Shoes',
      price: 159.99,
    ),
    Product(
      id: 'p7',
      name: 'Adidas Ultra-boost',
      description: 'Top performance running shoes from Adidas.',
      imageUrl: 'https://m.media-amazon.com/images/I/81fvie4AaBL._SX675_.jpg',
      brand: 'Adidas',
      category: 'Shoes',
      price: 179.99,
    ),
    Product(
      id: 'p8',
      name: 'Canon EOS 90D',
      description: 'High resolution DSLR for professional photography.',
      imageUrl: 'https://m.media-amazon.com/images/I/6199vs7UjZL._AC_UY218_.jpg',
      brand: 'Canon',
      category: 'Cameras',
      price: 1199.99,
    ),
    Product(
      id: 'p9',
      name: 'MacBook Air M2',
      description: 'Ultra portable laptop with Apple silicon.',
      imageUrl: 'https://m.media-amazon.com/images/I/71f5Eu5lJSL._AC_UY218_.jpg',
      brand: 'Apple',
      category: 'Laptops',
      price: 1249.99,
    ),
    Product(
      id: 'p10',
      name: 'Samsung 55" QLED TV',
      description: 'Smart TV with quantum dot technology.',
      imageUrl: 'https://m.media-amazon.com/images/I/81cbFZwHYYL._AC_UY218_.jpg',
      brand: 'Samsung',
      category: 'Television',
      price: 899.99,
    ),
    Product(
      id: 'p11',
      name: 'JBL Flip 6',
      description: 'Portable waterproof Bluetooth speaker.',
      imageUrl: 'https://m.media-amazon.com/images/I/61HpQ8FOCNL._AC_UY218_.jpg',
      brand: 'JBL',
      category: 'Speakers',
      price: 129.99,
    ),
    Product(
      id: 'p12',
      name: 'Lenovo Legion 5',
      description: 'High-performance gaming laptop.',
      imageUrl: 'https://m.media-amazon.com/images/I/81oiU1oIFOL._AC_UY218_.jpg',
      brand: 'Lenovo',
      category: 'Laptops',
      price: 1399.99,
    ),
    Product(
      id: 'p13',
      name: 'Google Pixel 7',
      description: 'Google’s latest smartphone with clean Android.',
      imageUrl: 'https://m.media-amazon.com/images/I/61bFypVJVyL._AC_UY218_.jpg',
      brand: 'Google',
      category: 'Mobiles',
      price: 799.99,
    ),
    Product(
      id: 'p14',
      name: 'HP Envy x360',
      description: '2-in-1 laptop for work and creativity.',
      imageUrl: 'https://m.media-amazon.com/images/I/61YEGRJb7oL._AC_UY218_.jpg',
      brand: 'HP',
      category: 'Laptops',
      price: 1099.99,
    ),
    Product(
      id: 'p15',
      name: 'Realme Buds Q2',
      description: 'Affordable wireless earbuds with noise cancellation.',
      imageUrl: 'https://m.media-amazon.com/images/I/61gmciQoOKL._AC_UY218_.jpg',
      brand: 'Realme',
      category: 'Earbuds',
      price: 39.99,
    ),
    Product(
      id: 'p16',
      name: 'Fitbit Charge 5',
      description: 'Fitness tracker with built-in GPS.',
      imageUrl: 'https://m.media-amazon.com/images/I/51q7FojdicL._AC_UL320_.jpg',
      brand: 'Fitbit',
      category: 'Fitness',
      price: 149.99,
    ),
    Product(
      id: 'p17',
      name: 'Acer Nitro 5',
      description: 'Entry level gaming laptop with great value.',
      imageUrl: 'https://m.media-amazon.com/images/I/41hFiucyECL._AC_UY218_.jpg',
      brand: 'Acer',
      category: 'Laptops',
      price: 999.99,
    ),
    Product(
      id: 'p18',
      name: 'OnePlus Nord 3',
      description: 'Mid-range phone with powerful specs.',
      imageUrl: 'https://m.media-amazon.com/images/I/6116+vSW+1L._AC_UY218_.jpg',
      brand: 'OnePlus',
      category: 'Mobiles',
      price: 499.99,
    ),
    Product(
      id: 'p19',
      name: 'LG 65" OLED TV',
      description: 'Ultra HD OLED display with Dolby Vision.',
      imageUrl: 'https://m.media-amazon.com/images/I/71In4n+mlVL._AC_UY218_.jpg',
      brand: 'LG',
      category: 'Television',
      price: 1999.99,
    ),
    Product(
      id: 'p20',
      name: 'Bose QuietComfort 45',
      description: 'Comfortable ANC headphones for travel.',
      imageUrl: 'https://m.media-amazon.com/images/I/51ZR4lyxBHL._AC_UY218_.jpg',
      brand: 'Bose',
      category: 'Headphones',
      price: 329.99,
    ),
    Product(
      id: 'p21',
      name: 'Mi Smart Band 7',
      description: 'Affordable fitness tracker with AMOLED screen.',
      imageUrl: 'https://m.media-amazon.com/images/I/61-PhP53C2L._AC_UL320_.jpg',
      brand: 'Xiaomi',
      category: 'Fitness',
      price: 49.99,
    ),
    Product(
      id: 'p22',
      name: 'Asus ROG Phone 6',
      description: 'Gaming phone with high refresh rate display.',
      imageUrl: 'https://m.media-amazon.com/images/I/31QwUqcvKjL._AC_UY218_.jpg',
      brand: 'Asus',
      category: 'Mobiles',
      price: 899.99,
    ),
    Product(
      id: 'p23',
      name: 'Apple iPad Air',
      description: 'Powerful iPad with M1 chip.',
      imageUrl: 'https://m.media-amazon.com/images/I/617Is7Kd5iL._AC_UY218_.jpg',
      brand: 'Apple',
      category: 'Tablets',
      price: 599.99,
    ),
    Product(
      id: 'p24',
      name: 'Microsoft Surface Laptop 5',
      description: 'Elegant and lightweight laptop.',
      imageUrl: 'https://m.media-amazon.com/images/I/511VIcTtCXL._AC_UY218_.jpg',
      brand: 'Microsoft',
      category: 'Laptops',
      price: 1299.99,
    ),
    Product(
      id: 'p25',
      name: 'GoPro HERO11',
      description: 'Action camera with high frame rate recording.',
      imageUrl: 'https://m.media-amazon.com/images/I/41dr2z-ClFL._SX300_SY300_QL70_FMwebp_.jpg',
      brand: 'GoPro',
      category: 'Cameras',
      price: 499.99,
    ),
  ];


  // for (final product in dummyProducts) {
  //   await products.addProduct(
  //     product.name,
  //     product.description,
  //     product.imageUrl,
  //     product.brand,
  //     product.category,
  //   );
  // }
  for (var product in dummyProducts) {
    await ref.child(product.id).set(product.toMap());
  }


  // ScaffoldMessenger.of(context).showSnackBar(
  //   const SnackBar(content: Text(' dummy products added')),
  // );
}
