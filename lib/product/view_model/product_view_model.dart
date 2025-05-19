import 'package:amazon_clone/cart/model/cart_model.dart';
import 'package:amazon_clone/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/product_model.dart';


class ProductViewModel with ChangeNotifier {
  final List<Product> _products = [];

  final List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;
  String _searchQuery = '';
  String _selectedCategory = 'All';

  String get selectedCategory => _selectedCategory;

  List<Product> get products => _searchQuery.isEmpty
      ? _products
      : _products.where((p) =>
  p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      p.category.toLowerCase().contains(_searchQuery.toLowerCase())).toList();



  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }


  List<String> get uniqueCategories {
    return _products
        .map((product) => product.category)
        .toSet()
        .toList();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
  List<Product> get filteredCategoryProducts {
    if (_selectedCategory.isEmpty || _selectedCategory == 'All') {
      return products;
    }
    return products.where((p) => p.category == _selectedCategory).toList();
  }

  void fetchProducts() async {
    final dbRef = FirebaseDatabase.instance.ref('products');
    final snapshot = await dbRef.get();
    _products.clear();
    for (final child in snapshot.children) {
      final product = Product.fromMap(Map<String, dynamic>.from(child.value as Map), child.key!);
      _products.add(product);
    }
    notifyListeners();
  }

// Cart functionality
  Future<void> addToCart(Product product, String userId) async {
    try {
      final cartRef = FirebaseDatabase.instance.ref('cart/$userId/${product.id}');
      final cartItem = CartItem(
        pid: product.id,
        userId: userId,
        name: product.name,
        imageUrl: product.imageUrl,
        price: product.price, brand: product.brand,description: product.description
      );
      await cartRef.set(cartItem.toMap());
      await fetchCartItems(userId);

    } catch (e) {
      debugPrint('Error in addToCart: $e');

    }
  }

  Future<void> removeFromCart(String productId, String userId,) async {
    try {
      final cartRef = FirebaseDatabase.instance.ref('cart/$userId/$productId');
      await cartRef.remove();
      await fetchCartItems(userId);

    } catch (e) {
      debugPrint('Error in removeFromCart: $e');

    }
  }

  Future<void> fetchCartItems(String userId) async {
    try {
      final dbRef = FirebaseDatabase.instance.ref('cart/$userId');
      final snapshot = await dbRef.get();
      _cartItems.clear();
      if (snapshot.exists) {
        for (final child in snapshot.children) {
          final cartItem = CartItem.fromMap(
            Map<String, dynamic>.from(child.value as Map),
            child.key!,
          );
          _cartItems.add(cartItem);
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error in fetchCartItems: $e');
    }
  }

  Future<void> updateQuantity(String userId, String pid, int newQuantity) async {
    try {
      final ref = FirebaseDatabase.instance.ref('cart/$userId/$pid');
      await ref.update({'quantity': newQuantity});
      await fetchCartItems(userId);
    } catch (e) {
      debugPrint('Error in updateQuantity: $e');
    }
  }

  bool isInCart(String productId) {
    return _cartItems.any((item) => item.pid == productId);
  }

  int get totalCartCount {
    int count = 0;
    for (final item in _cartItems) {
      count += item.quantity;
    }
    return count;
  }


  Future<void> addProduct(String name, String description, String imageUrl, String brand, String category) async {
    final dbRef = FirebaseDatabase.instance.ref('products').push();
    final newProduct = {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'brand': brand,
      'category': category,
    };
    await dbRef.set(newProduct);
    fetchProducts();
  }
}
