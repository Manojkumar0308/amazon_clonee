class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String brand;
  final String category;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.brand,
    required this.category,
    required this.price
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      brand: map['brand'] ?? '',
      category: map['category'] ?? '',
      price: map['price'] ?? 0.0
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'brand': brand,
      'category': category,
      'price':price
    };
  }
}
