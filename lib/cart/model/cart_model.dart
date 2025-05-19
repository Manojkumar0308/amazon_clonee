class CartItem {
  final String pid;          // Product ID
  final String userId;
  final String name;
  final String brand;
  final String description;
  final String imageUrl;
  final double price;
  final int quantity;

  CartItem({
    required this.pid,
    required this.userId,
    required this.name,
    required this.brand,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });

  factory CartItem.fromMap(Map<String, dynamic> map, String pid) {
    return CartItem(
      pid: pid,
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      brand: map['brand'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      quantity: map['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'brand': brand,
      'description':description,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }
}
