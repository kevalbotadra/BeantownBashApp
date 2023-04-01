import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String title;
  final String imageUrl;
  final String price;
  final String size;

  Item({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.size,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
        title: map["title"],
        size: map["size"],
        imageUrl: map["imageUrl"],
        price: map["price"]);
  }
}


