import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String brand;
  final String category;
  final String description;
  final double discountPercentage;
  final int id;
  final List images;
  final int price;
  final double rating;
  final int stock;
  final String thumbnail;
  final String title;

  const Product({
    required this.brand,
    required this.category,
    required this.description,
    required this.discountPercentage,
    required this.id,
    required this.images,
    required this.price,
    required this.rating,
    required this.stock,
    required this.thumbnail,
    required this.title,
  });

  factory Product.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw Exception("Document data was null for ${snapshot.id}");
    }
    return Product(
      brand: data['brand'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      discountPercentage: data['discountPercentage'] ?? 0.0,
      id: data['id'] ?? 0,
      images: data['images'] ?? [],
      price: data['price'] ?? 0,
      rating: (data['rating'] ?? 0).toDouble(),
      stock: data['stock'] ?? 0,
      thumbnail: data['thumbnail'] ?? '',
      title: data['title'] ?? '',
    );
  }
}
